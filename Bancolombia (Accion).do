*ACCION BANCOLOMBIA 
import delimited "C:\Users\jhona\Desktop\Brayan\Github\Derivados-Financieros\Bases de datos\Datos históricos BIC (1).csv", varnames(1) encoding(UTF-8) parselocale(es_CO) groupseparator(.) decimalseparator(,) stringcols(1) clear  

generate fecha2 = date(fecha,"DMY")
tsset fecha2, daily

tsline último

summarize