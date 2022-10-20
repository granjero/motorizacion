/**********************************************
Engranajes para motorizacion montura dobson.
Diseño de la montura basado en el de la 
Asociacón de Amigos de la Astronomía
(https://www.amigosdelaastronomia.org/)

Softare libre.

***********************************************/
include <gears.scad> // https://github.com/chrisspen/gears

// PARAMETROS MONTURA
RADIO_BASE_MONTURA = 240;

// PARAMETROS CORONA
MODULO = 1.242;
CANT_DIENTES_CORONA = 360;
ALTO_CORONA = 15;
ANCHO_CORONA = 15;
DIAMETRO_CORONA = 480; // ejecutar el programa una vez y copiar el valor de ECHO: "Ring Gear Outer Diamater = "

PARTES = 6; // CANTIDAD DE PARTES EN LA QUE SE DIVIDIRA LA CORONA PARA IMPRIMIR 3D

TORNILLOS = 6; // CANTIDAD DE ORIFICIOS EN LA CORONA PARA IMPRIMIR


// COMENTAR O DESCOMENTAR SEGUN CORRESPONDA
baseMontura(); // comentar al hacer el render para imprimir
/*coronaCompleta(); // comentar al hacer el render para imprimir  */
//coronaDivididaEnPartes(); // comentar al hacer el render para imprimir
//orificiosParaTornillos (); // comentar al hacer el render para imprimir
coronaPara3D();

// base montura
// color => color para el render
module baseMontura(color = "Indigo")
{
    translate([0,0,-25])
    color(color, 0.4) {
        union(){
            cylinder(h = 18, r = RADIO_BASE_MONTURA,center = true);
        }
    }
}

// Dibuja la corona completa. Sólo para visualizar.
module coronaCompleta()
{
        ring_gear (modul=MODULO, tooth_number=CANT_DIENTES_CORONA, width=ALTO_CORONA, rim_width=ANCHO_CORONA, pressure_angle=20, helix_angle=0);
}

// Divide la corona en partes
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

// Hace los orificios para montar la corona en la base con tornillos
module orificiosParaTornillos ()
{
    for(i = [0 : TORNILLOS])
    {
        rotate([0,0,-i*360/PARTES/TORNILLOS])
        translate([DIAMETRO_CORONA/2-ANCHO_CORONA/2, 0,0])
        cylinder(h = ALTO_CORONA*2, d = 4 );
    }
}

// Hace el render de la corona cortada en las partes necesarias para imprimir en 3D
module coronaPara3D ()
{
    difference(){
        coronaDivididaEnPartes();
        orificiosParaTornillos();
    }
}
