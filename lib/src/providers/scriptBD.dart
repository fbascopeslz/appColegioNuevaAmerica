String scriptBD() {
  return "create table asistencia"
"("
"	id INTEGER PRIMARY KEY,"
"	fecha Timestamp not null,"
" tipoAsistencia varchar(1),"
" alumnoid int not null,"
" nombreAlumno varchar(150),"
" ofertaid int not null,"
"periodoid int not null"
");"
;}