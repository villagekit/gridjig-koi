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
//! ***
//!
//! Hardware design assets and documentation licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), `.scad` files licensed under GPL-3.0 (as with NopSCADlib).

include <NopSCADlib/lib.scad> 

include <./lib.scad>

// $show_threads = true;

//! Main assembly
module main_assembly()
assembly("main") {
}

if($preview) {
  main_assembly();
}
