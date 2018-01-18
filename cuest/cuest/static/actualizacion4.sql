drop table if exists preguntas;
create table preguntas(
id_pregunta integer primary key auto_increment,
pregunta varchar(250),
campos integer, 
tipo integer);

drop table if exists respuestas;
create table respuestas(
id_resuesta integer primary key,
respuesta varchar(250),
idPregunta integer,
foreign key (idPregunta) references preguntas(id_pregunta)
);

drop table if exists usuario;
create table usuario(
id_usuario integer primary key auto_increment,
nombre varchar(200),
tipo integer,
password varchar(16)
);

drop table if exists cuestionario;
create table cuestionario(
id_cuestionario integer primary key auto_increment,
id_usuario integer,
foreign key (id_usuario) references usuario(id_usuario)
);

drop table if exists preguntas_respuestas;
create table preguntas_respuestas(
id_preg_resp integer primary key auto_increment,
id_cuestionario integer,
id_pregunta integer,
id_resuesta integer,
vchar varchar(400),
entero integer,
flotante decimal(10,2),
foreign key (id_cuestionario) references cuestionario(id_cuestionario),
foreign key (id_pregunta) references preguntas(id_pregunta),
foreign key (id_resuesta) references respuestas(id_resuesta),
);



insert into preguntas(pregunta, campos, tipo) values
("Nombre", 1, 1),
("Genero", null, null),
("Delegación", null, null),
("Edad", null, null),
("Modalidad", null, null),
("Rubro disciplinario", null, null),
("1.    ¿Su actividad artística cultural, la realiza de manera individual o forma parte de un colectivo/ empresa?", null, null),
("2.    ¿Cuántos integrantes son?  ", 1, 2),
("3.    La compañía / Grupo/ Colectivo ¿está legalmente constituida?", null, null),
("4.    ¿Cómo fue su acercamiento al mundo del arte? INSISTIR Y PROFUNDIZAR", 3, 1),
("5.    Con base a esta tarjeta en que disciplina desarrolla su principal actividad Artístico-Cultural? (MOSTRAR TARJETA DE DISCIPLINA y ANOTA EN EL CÓDIGO CORRESPONDIENTE LA RESPUESTA)", null, null),
("6.    ¿Ha estudiado formalmente esta disciplina Artístico-Cultural… (MENCIONAR RESPUESTA DE PREGUNTA ANTERIOR)", null, null),
("7.    ¿En dónde la estudio?", 1, 1),
("8.    ¿Por qué eligió esta disciplina artística y no otra?  ¿Algún otro motivo? INSISTIR Y PROFUNDIZAR", 3, 1),
("9.    ¿Estudió  alguna otra carrera? ", null, null),
("9.    ¿Cual? ", 1, 1),
("10.   ¿Cuáles son los motivos por los que se dedicó al arte?  ¿Algún otro motivo?  INSISTIR Y PROFUNDIZAR", 3, 1),
("11.   Por su carrera Artístico-Cultural ¿Ha tenido que posponer algunos proyectos, de cualquier tipo?", null, null),
("12.    ¿Qué proyectos ha tenido que posponer por su actividad artística cultural?", 3, 1),
("13.   Profesionalmente ¿cuánto tiempo  lleva de  trayectoria en el ámbito Artístico-Cultural? ", 2, 2),
("14.   ¿Qué aspectos Le gustan más de su trabajo?", 3, 1),
("14b    ¿Qué  desea trasmitir o comunicar a los demás con su trabajo Artístico-Cultural? INSISTIR Y PROFUNDIZAR", 3, 1),
("15.   ¿Qué aspectos, factores o condiciones le gustan menos de su trabajo artístico-Cultural? INSISTIR Y PROFUNDIZAR ", 3, 1),
("16.   ¿Cuáles son las dificultades más grandes que ha tenido para realizar su actividad Artístico-Cultural? INSISTIR Y PROFUNDIZAR   ", 3, 1),
("17.   ¿En qué delegaciones ha desarrollado su actividad Artístico-Cultural?  ", null, 5),
("18.   En cuál de estas ha desarrollado más su actividad artístico-cultural?", null, null),
("19.   Cuántos días a la semana le dedica a su actividad Artístico-Cultural", 1, 2),
("19b ¿Qué días?", null, 5),
("20.   ¿Cuántas horas MÍNIMO al día le dedica… (MENCIONAR CADA DÍA DE RESPUESTA ANTERIOR)?", 1, 4),
("20a Lunes", 1, 2),
("20b Martes", 1, 2),
("20c Miércoles", 1, 2),
("20d Jueves", 1, 2),
("20e Viernes", 1, 2),
("20f Sábado", 1, 2),
("20g Domingo" 1, 2),
("21.   ¿Cuál es el MÁXIMO número de horas que le ha dedicado a su trabajo sin parar? ", 1, 3),
("22.   ¿Quién  contrata más sus servicios culturales o compra sus productos? ¿Quién más? ESPECIFICAR ", 1, 1),
("23.   Pensando en los materiales, la gente que participa, transportación y demás gastos ¿cuánto cuesta desarrollar sus servicios artísticos culturales o productos, cuál sería el costo mínimo y cuál sería el costo máximo?", null, 4),
("Min ", 1, 3),
("Max ", 1, 3),
("24.   Pensando en ganancias ¿cuál sería el porcentaje mínimo que ha obtenido Y cuál el máximo?", null, 4),
("Min ", 1, 3),
("Max ", 1, 3),
("25.   Pensando en el 2016 ¿Cada cuándo tuvo contratos? ", 1, 1),
("25B   ¿Y cuál es la duración mínima y Cuál la máxima?", null, 4),
("Min ", 1, 1),
("Max ", 1, 1),
("26.   En 2016 ¿Cuál fue su ingreso mínimo mensual por su actividad Artístico- Cultural? Y ¿cuál el máximo?", null, 4),
("Min ", 1, 3),
("Max ", 1, 3),
("27.   Y cómo considera qué fue su ingreso económico en 2016 por su actividad Artístico- Cultural?", null, null),
("28.   ¿En qué meses no tiene actividad o proyectos de su quehacer o actividad artístico – cultural? ", null, 5),
("29.   En el tiempo que no tiene actividad o proyectos ¿a qué se dedica?", 3, 1),
("30.   A parte de su actividad artística – cultural ¿usted necesita trabajar en otra actividad que le  proporcione ingresos?", null, null),
("31.   ¿En qué trabaja?", 3, 1),
("32.   ¿Participó, en el 2016, en el desarrollo de algún  proyecto o actividad  que involucrara su disciplina artístico cultural, sin recibir pago?", null, null),
("33.   ¿Cómo es la demanda en el mercado de su disciplina artística en dónde se desempeña? INSISTIR Y PROFUNDIZAR", 3, 1),
("34.   Al año ¿Cuántos clientes puede tener en su actividad artístico cultural como mínimo? ¿Cuántos como máximo? ", null, 4),
("Min ", 1, 2),
("Max ", 1, 2),
("35.   ¿Aproximadamente, cuántos proyectos artísticos realizó en el 2016?  ", 1, 2),
("36.   De esos ¿cuántos fueron firmados o de palabra? ", null, 4),
("Firmados ", 1, 2),
("Palabra ", 1, 2),
("37.   Y ¿En cuántos proyectos le pidieron recibo de honorarios o factura? "),
("Honorarios ", 1, 2),
("Factura ", 1, 2),
("38.   ¿Qué tipo de prestaciones tiene en su trabajo? ¿Alguna otra?", 3, 1),
("39.   ¿Tiene Seguridad Social?  ", null, null),
("¿Cuál?", 1, 1),
("40.   La tiene por…", null, null),
("Especificar ", 1, 1)
("41.   ¿Tiene conocimiento de derechos laborales y de políticas culturales? ", null, null),
("42.   Para realizar sus actividades ARTISTICO- CULTURAL ¿Contrata  colaboradores? ", null, null),
("43.   ¿De qué tipo de colaboradores se apoya? ESPECIFICAR", 3, 1),
("44.   ¿Cuál es la duración MINIMA Y  MAXIMA DE  SUS PROYECTOS?", null, 4),
("Min ", 1, 2),
("Max ", 1, 2),
("45.   ¿Pertenece a redes artísticas de colaboración que le faciliten su quehacer artístico?", null, null),
("46.   ¿Cuáles? ¿Alguna otra?", 3, 1),
("47.   Tiene algún espacio que utilice solo para realizar su actividad artístico cultural", null, null),
("Especificar", 1, 1),
("48.   Es su casa o algún otro espacio exclusivo para actividad artistico -cultural", null, null),
("49.   ¿Qué tipo de mantenimiento le dan al lugar? ", 3, 1),
("50.   ¿El espacio está dado de alta PARA LA ACTIVIDAD ARTÍSTICO- CULTURAL?", null, null),
("51.   ¿Cuál es la ruta para gestionar o conseguir un espacio para el quehacer artístico en el ámbito Gubernamental?", 3, 1),
("52.   ¿Cuál es la ruta para gestionar o conseguir un espacio para el quehacer artístico en la iniciativa privada? ", 3, 1),
("53.   ¿Cuál es la ruta para gestionar o conseguir un espacio para el quehacer artístico en el espacio público?", 3, 1),
("54.   ¿Cuánto tiempo, MÍNIMO, ha tardado en  conseguir recursos para sus proyectos Artísticos Culturales?  ¿y cuál máximo?", null, 4),
("Min ", 1, 3),
("Max ", 1, 3),
("55.   ¿En qué convocatorias ha participado o aplicado?", 3, 1),
("56.   ¿A qué instancias o instituciones pertenecían?", 3, 1),
("57.   ¿En qué año?", 3, 1),
("58.   Con base a esta tarjeta ¿Cuáles son las principales fuentes solicitadas para financiar su actividad artístico cultural?", null, 5),
("Especificar", 1, 1),
("59.   ¿Ha solicitado crédito para financiar su Actividad Artístico Cultural?", null, null),
("60.   ¿Cuándo solicitó el crédito? ", 1, 6),
("61.   ¿En qué institución los solicitó?", 1, 1),
("62.   ¿Cuál fue el monto?"1, 3),
("63.   ¿Cómo fue la periodicidad de los pagos", 1, 1),
("64.   ¿Qué requisitos le solicitaron?", 3, 1),
("65.   A su criterio ¿cuáles  serían las características de debe tener un  establecimiento cultural?", 3, 1),
("66.   ¿Cuáles son las características de una empresa cultural?  Qué más?", 3, 1),
("67.   ¿Qué talleres o cursos de corte administrativo o gerencial, tomó en el 2016  para mejorar o profesionalizar su actividad artístico-cultural? ", 3, 1),
("68.   ¿Qué proyecto le ha marcado en su carrera Artístico- Cultural?", 1, 1),
("69.   Como consecuencia de su quehacer artístico ¿Qué enfermedades o padecimientos ha sufrido? ", 3, 1),
("DO1 Contando todos los focos que hay en su hogar, dígame ¿Cuántos focos que estén funcionando tiene actualmente en su hogar?", 1, 2),
("D02 Sería tan amable de decirme su edad.", 1, 2),
("D03 ¿Cuál es su estado civil? ", null, null),
("D04 ¿Cuántas personas integran su familia, incluyéndose usted?  ", 1, 2),
("D05 ¿Tiene hijos? ", null, null),
("D05b ¿Cuántos?", 1, 2),
("D06. ¿Con cuáles de los siguientes artículos cuenta en su hogar? ", null, 5),
("D07 ¿Cuál es el total de cuartos, piezas o habitaciones con que cuenta su hogar?, por favor no incluya baños, medios baños, pasillos, patios y zotehuelas. ", 1, 2),
("D08 ¿Cuántos baños completos con regadera y W.C. (excusado) hay para uso exclusivo de los integrantes de su hogar?", 1, 2),
("D09 ¿En su hogar cuenta con regadera funcionado en alguno de los baños?", null, null),
("D10 ¿El piso de su hogar es predominantemente de tierra, o de cemento, o de algún otro?", null, null),
("D11 ¿Cuántos automóviles propios, excluyendo taxis, tienen en su hogar?", 1, 2),
("D12 ¿De qué años son?", 4, 1),
("D13 ¿Cuántas televisiones a color funcionado tienen en este hogar?", null, null),
("D14  ¿Cuántas computadoras personales, ya sea de escritorio o lap top, tiene funcionando en este hogar?", 1, 2),
("D15  ¿Cuenta con teléfono móvil?", null, null),
("D16  Pensando en la persona que aporta la mayor parte del ingreso en este hogar, ¿cuál fue el último año de estudios que completó? (espere respuesta, y pregunte) ¿Realizó otros estudios? (reclasificar en caso necesario).", null, null),
("D17  ¿cuál fue el último año de estudios que UD completó? (espere respuesta, y pregunte) ¿Realizó otros estudios? (reclasificar en caso necesario).", null, null),
("D18 ¿En qué?", 1, 1),
("D19 La delegación donde vive es", null, null);

insert into respuestas( respuesta, idPregunta) values
("Masculino", 1),
("Femenino", 1),
("Álvaro Obregón", 3),
("Azcapotzalco", 3),
("Benito Juárez", 3),
("Coyoacán", 3),
("Cuajimalpa", 3),
("Cuauhtémoc", 3),
("Gustavo A. Madero", 3),
("Iztacalco", 3),
("Iztapalapa", 3),
("Magdalena Contreras", 3),
("Miguel Hidalgo", 3),
("Milpa Alta", 3),
("Tláhuac", 3),
("Tlalpan", 3),
("Venustiano Carranza", 3),
("Xochimilco ", 3),
("18 a 25", 4),
("26 a 30", 4)
("31 a 35", 4),
("36 a 40", 4),
("41 a 45", 4),
("46 a 55", 4),
("56 a más", 4),
("MANERA   INDIVIDUAL", 5),
("COLECTIVO", 5),
("EMPRESA", 5),
("Producción Artística, Museografía y Gestión Cultural", 6)
("Artes Escénicas", 6)
("Plásticas y Visuales", 6)
("Música", 6)
("Literatura, Producción Editorial y Lectura", 6)
("Danza", 6)
("Audiovisuales e Interactivos", 6)
("Diseño", 6)
("MANERA   INDIVIDUAL", 7),
("COLECTIVO", 7),
("EMPRESA", 7),
("Si", 9),
("No", 9),
("  Producciones escénicas, de festivales y representación artística", 11),
("Gestión de espacios culturales", 11),
("Promoción, difusión, extensión y mercadotecnia cultural.", 11),
("Programas de educación artística formal y no formal (talleres)", 11),
("Gestión de galerías de arte y museos", 11),
("Museología, museografía y curaduría", 11),
("Gestión de turismo cultural", 11),
("Visitas guiadas (museos y sitios históricos y de Patrimonio)", 11),
("Recorridos culturales", 11),
("Teatro", 11),
("Circo", 11),
("Escenografía", 11),
("Dramaturgia", 11),
("Clown y mimos", 11),
("Títeres", 11),
("Musicales", 11),
("Performance", 11),
("Narración oral", 11),
("Pintura", 11),
("Grabado", 11),
("Escultura", 11),
("Fotografía", 11),
("Dibujo", 11),
("Arte objeto tradicional y contemporáneo", 11),
("Arquitectura (diseño, producción y conservación)", 11),
("Restauración de bienes muebles.", 11),
("Grafitti", 11),
("Tags", 11),
("Música  (educación y producción)", 11),
("Opera", 11),
("Laudería", 11),
("Arte Sonoro", 11),
("Creación literaria", 11),
("Producción editorial y medios impresos", 11),
("Gestión de bibliotecas y programas de fomento a la lectura", 11),
("Danza Contemporánea", 11),
("Ballet", 11),
("Danza  Folklórica", 11),
("Danza  Indígena", 11),
("Hip-Hop", 11),
("Bailes de Salón", 11),
("Arte huichol", 11),
("Hueso y cuerno", 11),
("Cine y producción audiovisual", 11),
("Televisión", 11),
("Radio", 11),
("Software y programas creativos digitales", 11),
("Animación", 11),
("Diseño gráfico y editorial", 11),
("Diseño de moda y joyería", 11),
(" Diseño  Textil", 11),
("Diseño Digital", 11),
("Si", 12),
("No", 12),
("Si", 15),
("No", 15),
("Si", 18),
("No", 18),
("Álvaro Obregón", 25),
("Azcapotzalco", 25),
("Benito Juárez", 25),
("Coyoacán", 25),
("Cuajimalpa", 25),
("Cuauhtémoc", 25),
("Gustavo A. Madero", 25),
("Iztacalco", 25),
("Iztapalapa", 25),
("Magdalena Contreras", 25),
("Miguel Hidalgo", 25),
("Milpa Alta", 25),
("Tláhuac", 25),
("Tlalpan", 25),
("Venustiano Carranza", 25),
("Xochimilco ", 25),
("Álvaro Obregón", 26),
("Azcapotzalco", 26),
("Benito Juárez", 26),
("Coyoacán", 26),
("Cuajimalpa", 26),
("Cuauhtémoc", 26),
("Gustavo A. Madero", 26),
("Iztacalco", 26),
("Iztapalapa", 26),
("Magdalena Contreras", 26),
("Miguel Hidalgo", 26),
("Milpa Alta", 26),
("Tláhuac", 26),
("Tlalpan", 26),
("Venustiano Carranza", 26),
("Xochimilco ", 26),
("Lunes", 28),
("Martes", 28),
("Miercoles", 28),
("Jueves", 28),
("Viernes", 28),
("Sábado", 28),
("Domingo", 28),
("Bueno", 52),
("Regular", 52),
("Malo", 52),
("Enero", 53)
("Febrero", 53)
("Marzo", 53)
("Abril", 53)
("Mayo", 53)
("Junio", 53)
("Julio", 53)
("Agosto", 53)
("Septiembre", 53)
("Octubre", 53)
("Noviembre", 53)
("Diciembre", 53)
("Si", 55),
("No", 55),
("Si", 57),
("No", 57),
("Si", 70),
("No", 70),
("La tiene por su actividad artístico-cultural", 72),
("Personal la paga por su cuenta", 72),
("Esposo /esposa", 72),
("Familiar", 72),
("Otra especificar", 72),
("Si", 74),
("No", 74),
("Si", 75),
("No", 75),
("Si", 80),
("No", 80),
("Propio", 82),
("Rentado", 82),
("Prestado", 82),
("No tiene", 82),
("Otro", 82),
("Casa", 84),
("Otro espacio", 84),
("Si", 86),
("No", 86),
("Una Fondeadora", 98),
("Financiamiento Privado", 98),
("Banco", 98),
("Familia", 98),
("Mis ahorros", 98),
("Otro ", 98),
("Si", 59),
("No", 59),
("SOLTER@", 111),
("CASAD@", 111),
("UNION LIBRE", 111),
("DIVORCIAD@", 111),
("VIUD@", 111),
("Si", 113),
("No", 113),
("ASPIRADORA", 115),
("TOSTADOR DE PAN", 115),
("BOILER DE GAS", 115),
("ESTUFA DE GAS O ELÉCTRICA", 115),
("Si", 118),
("No", 118),
("Tierra o cemento (firme de )", 119),
("Otro tipo de material o acabado", 119),
("0", 122),
("1", 122),
("2", 122),
("3 o más", 122),
("Si", 124),
("No", 124),
("NO ESTUDIO", 125),
("PRIMARIA INCOMPLETA ", 125),
("PRIMARIA COMPLETA", 125),
("SECUNDARIA INCOMPLETA", 125),
("SECUNDARIA COMPLETA", 125),
("CARRERA COMERCIAL", 125),
("CARRERA TÉCNICA", 125),
("PREPARATORIA INCOMPLETA", 125),
("PREPARATORIA COMPLETA", 125),
("LICENCIATURA INCOMPLETA", 125),
("LICENCIATURA COMPLETA", 125),
("DIPLOMADO O MAESTRÍA", 125),
("NO ESTUDIO", 126),
("PRIMARIA INCOMPLETA ", 126),
("PRIMARIA COMPLETA", 126),
("SECUNDARIA INCOMPLETA", 126),
("SECUNDARIA COMPLETA", 126),
("CARRERA COMERCIAL", 126),
("CARRERA TÉCNICA", 126),
("PREPARATORIA INCOMPLETA", 126),
("PREPARATORIA COMPLETA", 126),
("LICENCIATURA INCOMPLETA", 126),
("LICENCIATURA COMPLETA", 126),
("DIPLOMADO O MAESTRÍA", 126),
("Álvaro Obregón", 128),
("Azcapotzalco", 128),
("Benito Juárez", 128),
("Coyoacán", 128),
("Cuajimalpa", 128),
("Cuauhtémoc", 128),
("Gustavo A. Madero", 128),
("Iztacalco", 128),
("Iztapalapa", 18),
("Magdalena Contreras", 128),
("Miguel Hidalgo", 128),
("Milpa Alta", 128),
("Tláhuac", 128),
("Tlalpan", 128),
("Venustiano Carranza", 128),
("Xochimilco ", 128);