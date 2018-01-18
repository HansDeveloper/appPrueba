
create database culturales;

use culturales;


create table preguntas(
id_pregunta integer primary key auto_increment,
pregunta varchar(250),
campos integer, 
tipo integer);


create table respuestas(
id_respuesta integer primary key,
respuesta varchar(250),
idPregunta integer,
foreign key (idPregunta) references preguntas(id_pregunta)
);


create table usuario(
id_usuario integer primary key auto_increment,
nombre varchar(200),
tipo integer,
password varchar(16)
);


create table cuestionario(
id_cuestionario integer primary key auto_increment,
id_usuario integer,
foreign key (id_usuario) references usuario(id_usuario)
);


create table preguntas_respuestas(
id_preg_resp integer primary key auto_increment,
id_cuestionario integer,
id_pregunta integer,
id_respuesta integer,
vchar varchar(400),
entero integer,
flotante decimal(10,2),
foreign key (id_cuestionario) references cuestionario(id_cuestionario),
foreign key (id_pregunta) references preguntas(id_pregunta),
foreign key (id_respuesta) references respuestas(id_respuesta)
);

