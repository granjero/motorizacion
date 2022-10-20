/**********************************************
Engranajes para motorizacion montura dobson.
Diseño de la montura basado en el de la 
Asociacón de Amigos de la Astronomía
(https://www.amigosdelaastronomia.org/)

Softare libre.

***********************************************/
include <gears.scad> // https://github.com/chrisspen/gears

// PARAMETROS CORONA
MODULO = 1.2;
CANT_DIENTES_CORONA = 360;
ALTO_CORONA = 15;
ANCHO_CORONA = 15;
DIAMETRO_CORONA = 501; // ejecutar el programa una vez y copiar el valor de ECHO: "Ring Gear Outer Diamater = "

// CANTIDAD DE PARTES PARA IMPRIMIR 3D
PARTES = 10;

// CANTIDAD DE ORIFICIOS EN LA CORONA PARA IMPRIMIR
TORNILLOS = 5;

// PARAMETROS MONTURA
RADIO_BASE_MONTURA = 240;

baseMontura();

/*coronaCompleta();*/
/*coronaDivididaEnPartes();*/
/*orificiosParaTornillos ();*/
coronaPara3D();

// base montura
// params:
//      radio => radio de la base de la montura donde irá la corona de engranajes
//      color => color para el render
module baseMontura(color = "Indigo")
{
    translate([0,0,-25])
    color(color, 0.3) {
        union(){
            cylinder(h = 18, r = RADIO_BASE_MONTURA,center = true);
            rotate_extrude(angle = 360, convexity = 10)
            translate([RADIO_BASE_MONTURA,0,0])
            circle(r = 9);
        }
    }
}


module coronaCompleta()
{
        ring_gear (modul=MODULO, tooth_number=CANT_DIENTES_CORONA, width=ALTO_CORONA, rim_width=ANCHO_CORONA, pressure_angle=20, helix_angle=0);
}

module coronaDivididaEnPartes() 
{
    difference()
    {
        coronaCompleta();

        rotate_extrude(angle = 360 - (360 / PARTES), convexity = 10)
        translate([DIAMETRO_CORONA/2, 0, 0])
        circle(r = 50);
    }
}

module orificiosParaTornillos ()
{
    difference()
    {
        coronaDivididaEnPartes();
        for(i = [0 : TORNILLOS])
        {
            rotate([0,0,-i*360/PARTES/TORNILLOS])
            translate([DIAMETRO_CORONA/2-ANCHO_CORONA/2, 0,0])
            cylinder(h = ALTO_CORONA*2, d = 4 );
        }
    }
}

module coronaPara3D ()
{
    orificiosParaTornillos();
}
