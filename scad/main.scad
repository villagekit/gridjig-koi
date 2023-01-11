//
// NopSCADlib: Copyright Chris Palmer 2018
// GridJig: Copyright Village Kit Limited 2023
//
// This file is licensed under the GPL-3.0 license, as with NopSCADlib.

//! A simple jig to bring [grid beam](https://gridbeam.xyz) production to everyone.
//!
//! Inspiration: https://sunrise.social/@villagekit/109560883732040486
//!
//! ***
//!
//! Here's a rough sketch with my understanding for how this jig may be used:
//!
//! <img alt="Rough sketch of jig" src="./sketch.jpg" height="512px" />
//!
//! The “positioner” is a flat bar with point-y etches in the side, laying on a table with a proto grid beam about to be drilled. A point-y bolt is in an initial pre-drilled hole on the proto grid beam, in the first etch on the positioner. A drill press is about to drill in the next hole.
//!
//! After the hole is drilled, the point-y bolt will be pulled out of the etch, the beam slid forward until the point-y bolt is pushed into the next etch, then the next hole will be drilled. The process repeats until all etches are used to drill holes in the corresponding positions.
//!
//! ***
//!
//! Hardware design assets and documentation licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), `.scad` files licensed under GPL-3.0 (as with NopSCADlib).

include <NopSCADlib/lib.scad> 

include <./lib.scad>

// $show_threads = true;

grid_unit_in_mm = 40;
gridbeam_hole_diameter = 8;

jig_size_in_grid_units = 20;

// https://onestopcuttingshop.co.nz/plasma-cutting
positioner_sheet_type = AL8;
positioner_length = jig_size_in_grid_units * grid_unit_in_mm;
positioner_width = 20;
// positioner_height = (1 / 2) * (gridbeam_unit + gridbeam_hole_diameter);

positioner_point_width = gridbeam_hole_diameter;

//! The main plate of the jig, which aligns the hole positions to the beam.
module positioner_dxf() {
  dxf("positioner");

  difference() {
    translate([
      (1/2) * positioner_length,
      (1/2) * positioner_width,
    ])
    sheet_2D(
      positioner_sheet_type,
      positioner_length,
      positioner_width,
      2
    );

    for (hole_index = [0: jig_size_in_grid_units]) {
      translate([
        ((1/2) + hole_index) * grid_unit_in_mm,
        (1/2) * grid_unit_in_mm,
      ])
      rotate([0, 0, 45])
      square(positioner_point_width, center=true);
    }
  }
}

//! Main assembly
module main_assembly()
pose([0, 0, 0], [0, 0, 0]) // pose for readme
assembly("main") {
  translate([0, 0, (1/2) * sheet_thickness(positioner_sheet_type)])
  render_2D_sheet(positioner_sheet_type)
  positioner_dxf();
}

if($preview) {
  main_assembly();
}
