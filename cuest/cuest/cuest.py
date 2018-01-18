#!/usr/bin/env python
# -*- coding: utf-8 -*-


import os
import sys  
import sqlite3
import csv, operator
from flask import Flask, request, session, g, redirect, url_for, abort, render_template, flash
from flask_wtf import Form
from flask import send_from_directory
from wtforms import StringField, PasswordField, SelectField, IntegerField, SelectMultipleField, DecimalField, TextAreaField, DateField
from wtforms.validators import DataRequired, Email, Optional
from wtforms import widgets
# from flask_login import login_required

app = Flask(__name__, instance_relative_config=True) # instancia de la app
app.config.from_object(__name__) # carga configuración desde este archivo

# Carga configuración y sobreescribe la del ambiente
# app.root_path obtiene la ruta de la app
app.config.update(dict(
    DATABASE=os.path.join(app.root_path, 'cuest.db'),    
))

app.config.from_pyfile('setup.py') # carga configuración desde instance

# Se pueden incluir varios archivos de configuración, 
# flask cargará el último 
# hay que declararla antes de correr la app
app.config.from_envvar('CUEST_SETTINGS', silent=True)

reload(sys)  
sys.setdefaultencoding('utf8')

def connect_db():
    # Se conecta a la base eseada
    rv = sqlite3.connect(app.config['DATABASE'])
    rv.row_factory = sqlite3.Row
    return rv

def get_db():
    # Se conecta a la BD si no se ha conectado ya
    if not hasattr(g, 'sqlite_db'):
        g.sqlite_db = connect_db()
    return g.sqlite_db

@app.teardown_appcontext
def close_db(error):
    # Termina la conexión al terminar la petición.
    if hasattr(g, 'sqlite_db'):
        g.sqlite_db.close()

def init_db():
    db = get_db()
    with app.open_resource('empresas_culturales.sql', mode='r') as f:
        db.cursor().executescript(f.read())
    db.commit()

@app.cli.command('initdb')
def initdb_command(): 
    # Inicializa la base de datos
    init_db()
    print('La BD fue inicializada.')

@app.route('/', methods=["GET", "POST"])
def show_entries():
    db = get_db()
    cur = db.execute('select * from preguntas order by id_pregunta asc')
    preguntas = cur.fetchall()
    opcionales = [16, 19, 30, 31, 32, 33, 34, 35,
                     36, 56, 71, 73, 76, 81, 83, 97, 99, 
                     100, 101, 102, 103, 114, 127]
    class cuestForm(Form):
        pass

    for pregunta in preguntas:
        idPregunta = pregunta['id_pregunta']
        campos = pregunta['campos']
        tipo = pregunta['tipo']
        # Acción en caso de ser fija
        if (campos == None and tipo != 4):
            if (tipo == 5):
                setattr(cuestForm, str(idPregunta), MultiCheckboxField(pregunta['pregunta'], coerce=int, validators=[DataRequired()], description='Selecciona una o más opciones'))
            else:
                setattr(cuestForm, str(idPregunta), SelectField(pregunta['pregunta'], coerce=int, validators=[DataRequired()]))
        elif (campos > 2):
            if idPregunta in opcionales:
                setattr(cuestForm, str(idPregunta), TextAreaField(pregunta['pregunta'], validators=[Optional()]))
            else:
                setattr(cuestForm, str(idPregunta), TextAreaField(pregunta['pregunta']))
        else:
            if (tipo == 2):
                if idPregunta in opcionales:
                    setattr(cuestForm, str(idPregunta), IntegerField(pregunta['pregunta'], validators=[Optional()]))
                else:
                    setattr(cuestForm, str(idPregunta), IntegerField(pregunta['pregunta']))
            elif (tipo == 3):
                if idPregunta in opcionales:
                    setattr(cuestForm, str(idPregunta), DecimalField(pregunta['pregunta'], validators=[Optional()], places=2, rounding=None))
                else:
                    setattr(cuestForm, str(idPregunta), DecimalField(pregunta['pregunta'], places=2, rounding=None))
            elif (tipo == 4):
                if idPregunta in opcionales:
                    setattr(cuestForm, str(idPregunta), StringField(pregunta['pregunta'], validators=[Optional()], description='titulo'))
                else:
                    setattr(cuestForm, str(idPregunta), StringField(pregunta['pregunta'], description='titulo'))
            elif (tipo == 6):
                if idPregunta in opcionales:
                    setattr(cuestForm, str(idPregunta), DateField(pregunta['pregunta'], validators=[Optional()], description='aaa-mm-dd', format='%Y-%m-%d'))
                else:
                    setattr(cuestForm, str(idPregunta), DateField(pregunta['pregunta'], description='aaa-mm-dd', format='%Y-%m-%d'))
            else:
                if idPregunta in opcionales:
                    setattr(cuestForm, str(idPregunta), StringField(pregunta['pregunta'], validators=[Optional()]))
                else:
                    setattr(cuestForm, str(idPregunta), StringField(pregunta['pregunta']))
    # Inicializa el form
    form = cuestForm()

    for pregunta in preguntas:
        campos = pregunta['campos']
        idPregunta = pregunta['id_pregunta']
        tipo = pregunta['tipo']
        if (campos == None):
            curAnswers = db.execute('select * from respuestas where idPregunta = ?', (idPregunta,))
            answers = curAnswers.fetchall()
            if (tipo != 5):
                helpTxt = 'Selecciona una opción'
                form[str(idPregunta)].choices = [('-1', helpTxt)]                
                form[str(idPregunta)].choices += [(r['id_resuesta'], r['respuesta']) for r in answers]
            else:
                form[str(idPregunta)].choices = [(r['id_resuesta'], r['respuesta']) for r in answers]
            
            

    if form.validate_on_submit():
        db.execute("INSERT INTO usuario (nombre,tipo) VALUES (?,?)", (form[str(1)].data,0))
        db.commit()
        cur = db.execute('SELECT id_usuario from usuario where nombre = ? ORDER BY id_usuario DESC', (form[str(1)].data,))
        usuarios = cur.fetchall()
        db.execute("INSERT INTO cuestionario (id_usuario) VALUES (?)", (usuarios[0]))
        db.commit()
        cur = db.execute('SELECT id_cuestionario from cuestionario where id_usuario = ?', (usuarios[0]))
        idCuestionario = cur.fetchone()[0]
        for pregunta in preguntas:
            idPregunta = pregunta['id_pregunta']
            field = form[str(idPregunta)]
            if (field.type == 'MultiCheckboxField'):
                for dato in field.data:
                    db.execute('INSERT INTO preguntas_respuestas (id_cuestionario, id_pregunta, id_resuesta) VALUES (?, ?, ?)', (idCuestionario, idPregunta, dato))
            elif (field.type == 'SelectField'):
                db.execute('INSERT INTO preguntas_respuestas (id_cuestionario, id_pregunta, id_resuesta) VALUES (?, ?, ?)', (idCuestionario, idPregunta, field.data))
            elif (field.type == 'TextAreaField' or field.type == 'StringField'):
                if (field.description != 'titulo'):
                    db.execute('INSERT INTO preguntas_respuestas (id_cuestionario, id_pregunta, vchar) VALUES (?, ?, ?)', (idCuestionario, idPregunta, field.data))
            elif (field.type == 'IntegerField'):
                db.execute('INSERT INTO preguntas_respuestas (id_cuestionario, id_pregunta, entero) VALUES (?, ?, ?)', (idCuestionario, idPregunta, field.data))
            elif (field.type == 'DecimalField'):
                db.execute('INSERT INTO preguntas_respuestas (id_cuestionario, id_pregunta, flotante) VALUES (?, ?, ?)', (idCuestionario, idPregunta, float(field.data)))
        db.commit()
        return redirect(url_for('login'))

    return render_template('cuestionario.html', form=form)
@app.route('/uploads/<path:filename>', methods=["GET", "POST"])
def download(filename):
    
    
    db = get_db()
    csvsalida = open('encuesta.csv', 'w')
    salida = csv.writer(csvsalida)

    
    cur = db.execute('select * from preguntas_respuestas')
    entries = cur.fetchall()
    for quest in entries:
        print(quest)
        salida.writerow(quest)    

    

    csvsalida.close()

    #print(filename)

        
    return send_from_directory(os.getcwd(),
                               filename, as_attachment=True)
    #return 'Aquí'
    ##return render_template('cuestionario.html')

@app.route('/login', methods=["GET", "POST"])
def login():
    form = EmailPasswordForm()
    # print("Hola")
    if form.validate_on_submit():

        

        return redirect(url_for('show_entries'))
    # raise ValidationError("We're sorry, you must be 13 or older to register")
    return render_template('login.html', form=form)

# app.route siempre debe ir primero
# el @ es un decorador, se llama como una función que se ejecutará 
# antes de la función
# @app.route('/reporte')
# @login_required
# def account():
    # return render_template("reportes.html")
# Es posible usar un custom decorator para redirigir a los usuarios 
# sin cuenta, ver exploreflask.como

class EmailPasswordForm(Form):
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])

class MultiCheckboxField(SelectMultipleField):
    """
    A multiple-select, except displays a list of checkboxes.

    Iterating the field will produce subfields, allowing custom rendering of
    the enclosed checkbox fields.
    """
    widget = widgets.ListWidget(prefix_label=False)
    option_widget = widgets.CheckboxInput()