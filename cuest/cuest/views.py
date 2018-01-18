from flask import render_template, redirect, url_for

from . import app
from .forms import EmailPasswordForm

@app.route('/')
def show_entries():
    db = get_db()
    cur = db.execute('select pregunta from preguntas order by idPregunta asc')
    entries = cur.fetchall()
    return render_template('cuestionario.html', entries=entries)

# app.route siempre debe ir primero
# el @ es un decorador, se llama como una función que se ejecutará 
# antes de la función
# @app.route('/reporte')
# @login_required
# def account():
    # return render_template("reportes.html")
# Es posible usar un custom decorator para redirigir a los usuarios 
# sin cuenta, ver exploreflask.como