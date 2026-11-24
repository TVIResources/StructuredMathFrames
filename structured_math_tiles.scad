/*
UEB Math Teaching Module
Optimized version with customizer interface
*/

// ===== CUSTOMIZER PARAMETERS =====

/* [Component Selection] */
// Choose which component to render
component = "none"; // [ none:None,  time_keeping_UEB:Time Keeping (UEB),  add_subtract_UEB:Addition/Subtraction (UEB),  division_UEB:Division (UEB),  multiplication_UEB:Multiplication (UEB),  operation_symbol_multiply_UEB:Multiply Symbol (UEB),  operation_symbol_add_UEB:Add Symbol (UEB),  operation_symbol_subtract_UEB:Subtract Symbol (UEB),  numbers_1_UEB:Number 1 (UEB),  numbers_2_UEB:Number 2 (UEB),  numbers_3_UEB:Number 3 (UEB),  numbers_4_UEB:Number 4 (UEB),  numbers_5_UEB:Number 5 (UEB),  numbers_6_UEB:Number 6 (UEB),  numbers_7_UEB:Number 7 (UEB),  numbers_8_UEB:Number 8 (UEB),  numbers_9_UEB:Number 9 (UEB),  numbers_0_UEB:Number 0 (UEB),  numbers_null:Number Null,  time_keeping_print:Time Keeping (Print),  add_subtract_print:Addition/Subtraction (Print),  division_print:Division (Print),  multiplication_print:Multiplication (Print),  operation_symbol_multiply_print:Multiply Symbol (Print),  operation_symbol_add_print:Add Symbol (Print),  operation_symbol_subtract_print:Subtract Symbol (Print),  numbers_1_print:Number 1 (Print),  numbers_2_print:Number 2 (Print),  numbers_3_print:Number 3 (Print),  numbers_4_print:Number 4 (Print),  numbers_5_print:Number 5 (Print),  numbers_6_print:Number 6 (Print),  numbers_7_print:Number 7 (Print),  numbers_8_print:Number 8 (Print),  numbers_9_print:Number 9 (Print),  numbers_0_print:Number 0 (Print),   division_Nemeth:Division (Nemeth),   operation_symbol_multiply_nemeth:Multiply Symbol (Nemeth),  operation_symbol_add_nemeth:Add Symbol (Nemeth),  operation_symbol_subtract_nemeth:Subtract Symbol (Nemeth),  numbers_1_nemeth:Number 1 (Nemeth),  numbers_2_nemeth:Number 2 (Nemeth),  numbers_3_nemeth:Number 3 (Nemeth),  numbers_4_nemeth:Number 4 (Nemeth),  numbers_5_nemeth:Number 5 (Nemeth),  numbers_6_nemeth:Number 6 (Nemeth),  numbers_7_nemeth:Number 7 (Nemeth),  numbers_8_nemeth:Number 8 (Nemeth),  numbers_9_nemeth:Number 9 (Nemeth),  numbers_0_nemeth:Number 0 (Nemeth), storage_bay:Storage Bay, storage_bay_case:Storage Bay Case,  letters_a_UEB:Letter A (UEB),  letters_b_UEB:Letter B (UEB),  letters_c_UEB:Letter C (UEB),  letters_d_UEB:Letter D (UEB),  letters_e_UEB:Letter E (UEB),  letters_f_UEB:Letter F (UEB),  letters_g_UEB:Letter G (UEB),  letters_h_UEB:Letter H (UEB),  letters_i_UEB:Letter I (UEB),  letters_j_UEB:Letter J (UEB),  letters_k_UEB:Letter K (UEB),  letters_l_UEB:Letter L (UEB),  letters_m_UEB:Letter M (UEB),  letters_n_UEB:Letter N (UEB),  letters_o_UEB:Letter O (UEB),  letters_p_UEB:Letter P (UEB),  letters_q_UEB:Letter Q (UEB),  letters_r_UEB:Letter R (UEB),  letters_s_UEB:Letter S (UEB),  letters_t_UEB:Letter T (UEB),  letters_u_UEB:Letter U (UEB),  letters_v_UEB:Letter V (UEB),  letters_w_UEB:Letter W (UEB),  letters_x_UEB:Letter X (UEB),  letters_y_UEB:Letter Y (UEB),  letters_z_UEB:Letter Z (UEB),  letters_space_UEB:Blank Space Tile,  letters_a_print:Letter A (Print), letters_b_print:Letter B (Print), letters_c_print:Letter C (Print), letters_d_print:Letter D (Print), letters_e_print:Letter E (Print), letters_f_print:Letter F (Print), letters_g_print:Letter G (Print), letters_h_print:Letter H (Print), letters_i_print:Letter I (Print), letters_j_print:Letter J (Print), letters_k_print:Letter K (Print), letters_l_print:Letter L (Print), letters_m_print:Letter M (Print), letters_n_print:Letter N (Print), letters_o_print:Letter O (Print), letters_p_print:Letter P (Print), letters_q_print:Letter Q (Print), letters_r_print:Letter R (Print), letters_s_print:Letter S (Print), letters_t_print:Letter T (Print), letters_u_print:Letter U (Print), letters_v_print:Letter V (Print), letters_w_print:Letter W (Print), letters_x_print:Letter X (Print), letters_y_print:Letter Y (Print), letters_z_print:Letter Z (Print), letters_space_print:Blank Space (Print), storage_bay_words:Word and Sentence Board (4 Rows),  storage_bay_words_case:Word and Sentence Board Case]

/* [UEB Settings] */
// Radius of UEB dots (mm)
dot_radius = 0.25; // [0.15:0.05:0.5]
// Spacing between dots (mm)
dot_spacing = 2.5; // [2.0:0.1:3.0]
// Distance between characters (mm)
char_distance = 6.5; // [5.0:0.5:8.0]

/* [Plate Settings] */
// Plate height (mm)
plate_height = 10; // [5:1:20]
// Plate thickness (mm) - set to 2 for backing, 0 for dots only
plate_thickness = 7; // [0:1:15]

/* [Quality Settings] */
// Fragment number for curves
fragment_number = 12; // [8:2:64]

// ===== DERIVED PARAMETERS =====
radius = dot_radius;
spacingb = dot_spacing;
distance = char_distance;
$fn = fragment_number;

// Hole and spacing dimensions
hole_x_size = 11;
hole_y_size = distance * 2 + 1;
hole_z_size = 7;
spacing = 7;
raised_line_thickness = 2;

module letter_print_tile(label) {
  chars = ["", ""];
  char_count = 2;

  union() {
    rotate([0,270,0])
      UEB_str(chars, char_count);

    rotate([90,180,270]) {
      translate([6,-9,6])
        linear_extrude(2)
          text(label,
               font="Arial",
               size=8,
               halign="center");
    }
  }
}

module letter(bitmap) {
  row_size = 2;
  col_size = 3;
  bitmap_size = row_size * col_size;


  function loc_x(loc) =
    floor(loc / row_size) * spacingb + spacingb;
  function loc_y(loc) =
    loc % row_size * spacingb + (distance - spacingb) / 2;

  for(loc = [0:bitmap_size - 1]) {
    if (bitmap[loc] != 0) {
      UEB_dot_radius = dot_radius * bitmap[loc];
      union() {
        translate(v = [loc_x(loc), loc_y(loc), 0]) {
          sphere(radius = UEB_dot_radius);
          /* comment out for use with backing*/
          translate([0, 0, -0.5])
            cylinder(h = 1, r = 1, center = true);
        }
      }
    }
  }
}

/* This is a module for what to specifically type to get given UEB patterns */
module UEB_char(char) {
  // Letters a–z
  if (char == "a" || char == "A") {letter(
      [1,0,
       0,0,
       0,0] // 
  );} else if (char == "b" || char == "B") {letter(
      [1,0,
       1,0,
       0,0] //
  );} else if (char == "c" || char == "C") {letter(
      [1,1,
       0,0,
       0,0] //
  );} else if (char == "d" || char == "D") {letter(
      [1,1,
       0,1,
       0,0] // 
  );} else if (char == "e" || char == "E") {letter(
      [1,0,
       0,1,
       0,0] // 
  );} else if (char == "f" || char == "F") {letter(
      [1,1,
       1,0,
       0,0] // 
  );} else if (char == "g" || char == "G") {letter(
      [1,1,
       1,1,
       0,0] // 
  );} else if (char == "h" || char == "H") {letter(
      [1,0,
       1,1,
       0,0] // 
  );} else if (char == "i" || char == "I") {letter(
      [0,1,
       1,0,
       0,0] // 
  );} else if (char == "j" || char == "J") {letter(
      [0,1,
       1,1,
       0,0] // 
  );} else if (char == "k" || char == "K") {letter(
      [1,0,
       0,0,
       1,0] // 
  );} else if (char == "l" || char == "L") {letter(
      [1,0,
       1,0,
       1,0] // 
  );} else if (char == "m" || char == "M") {letter(
      [1,1,
       0,0,
       1,0] // 
  );} else if (char == "n" || char == "N") {letter(
      [1,1,
       0,1,
       1,0] // 
  );} else if (char == "o" || char == "O") {letter(
      [1,0,
       0,1,
       1,0] // 
  );} else if (char == "p" || char == "P") {letter(
      [1,1,
       1,0,
       1,0] // 
  );} else if (char == "q" || char == "Q") {letter(
      [1,1,
       1,1,
       1,0] // 
  );} else if (char == "r" || char == "R") {letter(
      [1,0,
       1,1,
       1,0] // 
  );} else if (char == "s" || char == "S") {letter(
      [0,1,
       1,0,
       1,0] // 
  );} else if (char == "t" || char == "T") {letter(
      [0,1,
       1,1,
       1,0] // 
  );} else if (char == "u" || char == "U") {letter(
      [1,0,
       0,0,
       1,1] // 
  );} else if (char == "v" || char == "V") {letter(
      [1,0,
       1,0,
       1,1] // 
  );} else if (char == "w" || char == "W") {letter(
      [0,1,
       1,1,
       0,1] // 
  );} else if (char == "x" || char == "X") {letter(
      [1,1,
       0,0,
       1,1] //
  );} else if (char == "y" || char == "Y") {letter(
      [1,1,
       0,1,
       1,1] // 
  );} else if (char == "z" || char == "Z") {letter(
      [1,0,
       0,1,
       1,1] // 
  );

  // Contractions
  } else if (char == "ch" || char == "CH") {letter(
      [1,0,
       0,0,
       0,1] // 
  );} else if (char == "sh" || char == "SH") {letter(
      [1,1,
       0,0,
       0,1] // 
  );} else if (char == "th" || char == "TH") {letter(
      [1,1,
       0,1,
       0,1] // 
  );} else if (char == "wh" || char == "WH") {letter(
      [1,0,
       0,1,
       0,1] // 
  );} else if (char == "ou" || char == "OU") {letter(
      [1,0,
       1,1,
       0,1] // 
  );} else if (char == "st" || char == "ST") {letter(
      [0,1,
       0,0,
       1,0] // 
  );} else if (char == "and" || char == "AND") {letter(
      [1,1,
       1,0,
       1,1] // 
  );} else if (char == "for" || char == "FOR") {letter(
      [1,1,
       1,1,
       1,1] // 
  );} else if (char == "of" || char == "OF") {letter(
      [1,0,
       1,1,
       1,1] // 
  );} else if (char == "the" || char == "THE") {letter(
      [0,1,
       1,0,
       1,1] // 
  );} else if (char == "with" || char == "WITH") {letter(
      [0,1,
       1,1,
       1,1] // 
  );

  // Shared patterns (digits + contractions + punct)
  } else if (char == "in" || char == "IN" || char == "9") {letter(
      [0,0,
       0,1,
       1,0] // 
  );} else if (char == "en" || char == "EN" || char == "5") {letter(
      [0,0,
       1,0,
       0,1] // 
  );} else if (char == "con" || char == "CON" || char == "cc" || char =="CC" || char == ":" || char == "3") {letter(
      [0,0,
       1,1,
       0,1] // 
  );} else if (char == "dis" || char == "DIS" || char == "ff" || char == "FF" || char == "." || char == "4") {letter(
      [0,0,
       1,1,
       0,1] // 
  );} else if (char == "be" || char == "BE" || char == "bb" || char == "BB" || char == "2") {letter(
      [0,0,
       1,0,
       1,0] // 
  );} else if (char == "ea" || char == "EA" || char == "1") {letter(
      [0,0,
       1,0,
       0,0] // 
  );} else if (char == "gg" || char == "GG" || char == "7") {letter(
      [0,0,
       1,1,
       1,1] // 
  );} else if (char == "!" || char == "6") {letter(
      [0,0,
       1,1,
       1,0] // 
  );} else if (char == "?" || char == "8") {letter(
      [0,0,
       1,0,
       1,1] // 
  );} else if (char == "closequote" || char == "CLOSEQUOTE" || char == "0") {letter(
      [0,0,
       0,1,
       1,1] // 
  );
      } else if (char == "openquote" || char == "OPENQUOTE" || char == "0") {letter(
      [0,0,
       1,0,
       1,1] // 
  );

  // Specials
  } else if (char == "cap" || char == "CAP") {letter(
      [0,0,
       0,0,
       0,1] // 
  );} else if (char == "#") {letter(
      [0,1,
       0,1,
       1,1] // 
  );} else if (char == "let" || char == "LET") {letter(
      [0,0,
       0,1,
       0,1] // 
  );} else if (char == "-") {letter(
      [0,0,
       0,0,
       1,1] // 
  );

  // Dot references
  } else if (char == "dot3" || char == "DOT3") {letter(
      [0,0,
       0,0,
       1,0] // 
  );} else if (char == "dot4" || char == "DOT4") {letter(
      [0,1,
       0,0,
       0,0] // 
  );} else if (char == "dot5" || char == "DOT5") {letter(
      [0,0,
       0,1,
       0,0] // 
  );} else if (char == "dot6" || char == "DOT6") {letter(
      [0,0,
       0,0,
       0,1] // 
  );} else if (char == "dots46" || char == "DOTS46") {letter(
      [0,1,
       0,0,
       0,1] // 
  );
  ;} else if (char == "dots456" || char == "DOTS456") {letter(
      [0,1,
       0,1,
       0,1] // 
  );

  } else if (char == "" || char == " ") {
    // Blank tile/cell: intentionally no raised dots.
  } else {
    echo("Invalid Character: ", char);
  }
}

module UEB_str(chars, char_count) {
  echo(str("Total Width: ", distance * char_count, "mm"));
  union() {
    for(count = [0:char_count - 1]) {
      translate(v = [0, count * distance, plate_thickness]) {
        UEB_char(chars[count]);
      }
    }
    translate(v = [0, -distance / 2 + 3, 0]) {
      color([0, 0, 1]) {
        cube(size = [plate_height, distance * (char_count), plate_thickness]);
    translate([1,.55,0]){cylinder(h=plate_thickness, r=1, $fn=64); }

      }
    }           
  }
}

//type required text in the following and adjust character count. Use "", for a blank space. You can use Capital or lowercase letters as they are normalized

module UEB_text() {
  chars = ["dot4", "CH"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}

module placeholder() {
  chars = ["#"];
  
  // number of characters. Increase for blank space on the plate
  char_count = 1;
  union() {
    rotate([0, 0, 270])
      UEB_str(chars, char_count);
  }
}
module operation_symbol_multiply_UEB() {
  chars = ["dot5", "8"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}

module operation_symbol_subtract_UEB() {
  chars = ["dot5", "-"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}

module operation_symbol_add_UEB() {
  chars = ["dot5", "6"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}

module numbers_1_UEB() {
  chars = ["a"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_2_UEB() {
  chars = ["b"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_3_UEB() {
  chars = ["c"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_4_UEB() {
  chars = ["d"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_5_UEB() {
  chars = ["e"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_6_UEB() {
  chars = ["f"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_7_UEB() {
  chars = ["g"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_8_UEB() {
  chars = ["h"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_9_UEB() {
  chars = ["i"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_0_UEB() {
  chars = ["j"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}




// =====================
// UEB braille alphabet tiles
// =====================
/* [UEB braille alphabet] */
module letters_a_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["a", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_b_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["b", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_c_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["c", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_d_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["d", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_e_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["e", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_f_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["f", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_g_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["g", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_h_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["h", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_i_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["i", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_j_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["j", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_k_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["k", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_l_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["l", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_m_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["m", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_n_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["n", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_o_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["o", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_p_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["p", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_q_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["q", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_r_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["r", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_s_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["s", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_t_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["t", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_u_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["u", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_v_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["v", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_w_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["w", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_x_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["x", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_y_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["y", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

module letters_z_UEB() {
  // One raised-dot letter cell plus one blank cell on the standard tile.
  chars = ["z", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
    }
module letters_space_UEB() {
  // A completely blank tile for separating words.
  chars = ["", ""];
  char_count = 2;
  rotate([0, 270, 0])
    UEB_str(chars, char_count);
}

// =====================
// Print Letters
// =====================
module letters_a_print() { letter_print_tile("A"); }
module letters_b_print() { letter_print_tile("B"); }
module letters_c_print() { letter_print_tile("C"); }
module letters_d_print() { letter_print_tile("D"); }
module letters_e_print() { letter_print_tile("E"); }
module letters_f_print() { letter_print_tile("F"); }
module letters_g_print() { letter_print_tile("G"); }
module letters_h_print() { letter_print_tile("H"); }
module letters_i_print() { letter_print_tile("I"); }
module letters_j_print() { letter_print_tile("J"); }
module letters_k_print() { letter_print_tile("K"); }
module letters_l_print() { letter_print_tile("L"); }
module letters_m_print() { letter_print_tile("M"); }
module letters_n_print() { letter_print_tile("N"); }
module letters_o_print() { letter_print_tile("O"); }
module letters_p_print() { letter_print_tile("P"); }
module letters_q_print() { letter_print_tile("Q"); }
module letters_r_print() { letter_print_tile("R"); }
module letters_s_print() { letter_print_tile("S"); }
module letters_t_print() { letter_print_tile("T"); }
module letters_u_print() { letter_print_tile("U"); }
module letters_v_print() { letter_print_tile("V"); }
module letters_w_print() { letter_print_tile("W"); }
module letters_x_print() { letter_print_tile("X"); }
module letters_y_print() { letter_print_tile("Y"); }
module letters_z_print() { letter_print_tile("Z"); }
module letters_space_print() { letter_print_tile(" "); }


module operation_symbol_multiply_nemeth() {
  chars = ["dot4", "CH"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}

module operation_symbol_subtract_nemeth() {
  chars = ["", "-"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}

module operation_symbol_add_nemeth() {
  chars = ["", "ING"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}

module numbers_1_nemeth() {
  chars = ["1"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_2_nemeth() {
  chars = ["2"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_3_nemeth() {
  chars = ["3"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_4_nemeth() {
  chars = ["4"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_5_nemeth() {
  chars = ["5"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_6_nemeth() {
  chars = ["6"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_7_nemeth() {
  chars = ["7"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_8_nemeth() {
  chars = ["8"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_9_nemeth() {
  chars = ["9"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}
module numbers_0_nemeth() {
  chars = ["0"];
      
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}




module numbers_null() {
  chars = [" "];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
  }
}


// A module for a single hole, translated to a relative position.
// This simplifies the placement logic in the main module.
module hole() {
  union() {
    translate([0, 0, -2])
      rotate([0, 0, 270])
        color("red") {
          cube(size = [hole_x_size, hole_y_size, hole_z_size]);
        }
    translate([7, 0, 5])
      sphere(r = 3);
    translate([7, -11, 5])
      sphere(r = 3);
  }
}


// The main module that generates the final object.
module add_subtract_UEB() {
  // Start with the main backing plate, centered.
  //cube([100, 100, 5], center = true);

  // Calculate the horizontal start position for the holes to ensure they are centered.
  // The total width of 4 holes with 3 spaces is: 4*10 + 3*7 = 61.
  // Since the backing is 100 wide and centered, the holes will be centered as well.
  // The offset to the first hole's center is calculated here.
  x_start = -((3 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);

  // Calculate the vertical (Y) positions for the rows and the raised line.
  // These are relative to the center of the backing plate.
  // Row 1: Positioned in the upper half.
  y1_pos = 15;
  // Row 2: Directly below Row 1, with a gap equal to the hole height plus spacing.
  y2_pos = y1_pos - (hole_y_size + spacing);
  // Raised Line: 7mm below the second row. We calculate its center.
  y_line_pos = y2_pos - (hole_y_size / 2) - spacing - (raised_line_thickness / 2);
  // Row 3: 7mm below the raised line.
  y3_pos = y_line_pos - (raised_line_thickness / 2) - spacing - (hole_y_size / 2);

  // Use a difference to subtract the holes from the backing.
  // The holes are translated to their calculated positions.
  difference() {
    // The main backing cube.
    cube([100, 100, 8], center = true);

    translate([0, 15, 0]) {
      // Subtract Row 1 (4 holes)
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y1_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0]) {
        translate([x_start + i * (hole_x_size + spacing) - 25, y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 3 (5 holes).
      // The last row has an additional hole to the left.
      // The new starting x position for the 5 holes is calculated.
      x_start_row3 = -((5 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);
      for(i = [0:4]) {
        translate([x_start_row3 + i * (hole_x_size + spacing), y3_pos, 0]) {
          hole();
        }
      }
    }
  }

  // Now, add the raised line using a union.
  union() {
    translate([-50, -10, 2]) {
      color("yellow") {
        cube([100, raised_line_thickness, 3]);
      }
      color("magenta") {
        translate([20, 40, -5])
          placeholder();
      }
      color("magenta") {
        translate([20, 18, -5])
          placeholder();
      }
      color("magenta") {
        translate([2, -12, -5])
          placeholder();
      }
    }
  }
}

// The main module that generates the final object.
module multiplication_UEB() {
  // Start with the main backing plate, centered.
  //cube([100, 100, 5], center = true);

  // Calculate the horizontal start position for the holes to ensure they are centered.
  // The total width of 4 holes with 3 spaces is: 4*10 + 3*7 = 61.
  // Since the backing is 100 wide and centered, the holes will be centered as well.
  // The offset to the first hole's center is calculated here.
  x_start = -((3 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);

  // Calculate the vertical (Y) positions for the rows and the raised line.
  // These are relative to the center of the backing plate.
  // Row 1: Positioned in the upper half.
  y1_pos = 55;
  // Row 2: Directly below Row 1, with a gap equal to the hole height plus spacing.
  y2_pos = y1_pos - (hole_y_size + spacing);
  // Raised Line: 7mm below the second row. We calculate its center.
  y_line_pos = y2_pos - (hole_y_size / 2) - spacing - (raised_line_thickness / 2);
  // Row 3: 7mm below the raised line.
  y3_pos = y_line_pos - (raised_line_thickness / 2) - spacing - (hole_y_size / 2);

  // Use a difference to subtract the holes from the backing.
  // The holes are translated to their calculated positions.
  difference() {
    // The main backing cube.
    cube([175, 150, 8], center = true);

    translate([20, 15, 0]) {
      // Subtract Row 1 (4 holes)
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y1_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0]) {
        translate([x_start + i * (hole_x_size + spacing) - 25, y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 3 (5 holes).
      // The last row has an additional hole to the left.
      // The new starting x position for the 5 holes is calculated.
      x_start_row3 = -((5 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);
      for(i = [0:4]) {
        translate([x_start_row3 + i * (hole_x_size + spacing), y3_pos, 0]) {
          hole();
        }
      }
      for(i = [0:5]) {
        translate([x_start_row3 + i * (hole_x_size + spacing) - 18, y3_pos - 25, 0]) {
          hole();
        }
      }
      for(i = [0:6]) {
        translate([x_start_row3 + i * (hole_x_size + spacing) - 35, y3_pos - 50, 0]) {
          hole();
        }
      }
      for(i = [0:7]) {
        translate([x_start_row3 + i * (hole_x_size + spacing) - 52, y3_pos - 75, 0]) {
          hole();
        }
      }
    }
  }

  union() {
    translate([-40, 75, 2]) {
      color("magenta") {
        translate([30, -6, -5])
          placeholder();
      }
      color("magenta") {
        translate([30, -27, -5])
          placeholder();
      }
      color("magenta") {
        translate([12, -57, -5])
          placeholder();
      }
      color("magenta") {
        translate([-5, -82, -5])
          placeholder();
      }
      color("magenta") {
        translate([-23, -107, -5])
          placeholder();
      }
      color("magenta") {
        translate([-40, -132, -5])
          placeholder();
      }

      for(i = [1])
        translate([0, i * -50, 0])
          color("yellow") {
            cube(size = [125, raised_line_thickness, 3]);
          }
          
    }
  }
}
module division_UEB() {
  // Calculate the horizontal start position for the holes to ensure they are centered.
  // The total width of 4 holes with 3 spaces is: 4*10 + 3*7 = 61.
  // Since the backing is 100 wide and centered, the holes will be centered as well.
  // The offset to the first hole's center is calculated here.
  x_start = -((3 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);

  // Calculate the vertical (Y) positions for the rows and the raised line.
  // These are relative to the center of the backing plate.
  // Row 1: Positioned in the upper half.
  y1_pos = 55;
  // Row 2: Directly below Row 1, with a gap equal to the hole height plus spacing.
  y2_pos = y1_pos - (hole_y_size + spacing);
  // Raised Line: 7mm below the second row. We calculate its center.
  y_line_pos = y2_pos - (hole_y_size / 2) - spacing - (raised_line_thickness / 2);
  // Row 3: 7mm below the raised line.
  y3_pos = y_line_pos - (raised_line_thickness / 2) - spacing - (hole_y_size / 2);

  // Use a difference to subtract the holes from the backing.
  // The holes are translated to their calculated positions.
  difference() {
    // The main backing cube.
    cube([175, 200, 8], center = true);

    translate([20, 40, 0]) {
      // Subtract Row 1 (4 holes)
      for(i = [0:5]) {
        translate([x_start + i * (hole_x_size + spacing) - 17, y1_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing) - 17, y2_pos - 4, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [1:2]) {
        translate([x_start + i * (hole_x_size + spacing) + -90, y2_pos - 5, 0]) {
          hole();
        }
      }

      // Subtract Row 3 (5 holes).
      // The last row has an additional hole to the left.
      // The new starting x position for the 5 holes is calculated.
      x_start_row3 = -((5 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);
      for(i = [0:6]) {
        for(j = [0:5]) {
          translate([x_start_row3 + i * (hole_x_size + spacing), y3_pos - j * 25, 0]) {
            hole();
          }
        }
      }
    }
  }
  // Now, add the raised line using a union.
  union() {
    translate([-40, 75, 2]) {
      color("yellow") {
        division_line();
      }
      color("magenta") {
        translate([-42, -8, -5])
          placeholder();
      }
      for(i = [0:7])
        color("magenta") {
          translate([12, 18 - 25 * i, -5])
            placeholder();
        }
             for(i = [2,4,6])
        color("magenta") {
          translate([-5, 18 - 25 * i, -5])
            rotate([0,90,270])operation_symbol_subtract_UEB();
       }

      for(i = [0:3])
        translate([0, i * -50, 0])
          color("yellow") {
            cube(size = [125, raised_line_thickness, 3]);
          }

    }
  }
}
// A module for the raised line.
module division_line() {
  $fn = 12;
  // The raised line has the same width as the rows of holes.
  cube(size = [125, raised_line_thickness, 3]);
  translate([-8, -16, 0])
    scale([.75, .75, 1]) {
      difference() {
        cylinder(3, 25, 25);
        translate([0, 0, -1])
          cylinder(5, 22, 22);
        translate([0, -40, -3])
          rotate([0, 0, 65])
            color("red") {
              cube([50, 50, 50]);
            }
        translate([-40, 0, -3])
          cube([50, 50, 50]);
        translate([-20, -60, -3])
          cube([50, 50, 50]);

      }
    }
}

module division_Nemeth() {
  // Calculate the horizontal start position for the holes to ensure they are centered.
  // The total width of 4 holes with 3 spaces is: 4*10 + 3*7 = 61.
  // Since the backing is 100 wide and centered, the holes will be centered as well.
  // The offset to the first hole's center is calculated here.
  x_start = -((3 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);

  // Calculate the vertical (Y) positions for the rows and the raised line.
  // These are relative to the center of the backing plate.
  // Row 1: Positioned in the upper half.
  y1_pos = 55;
  // Row 2: Directly below Row 1, with a gap equal to the hole height plus spacing.
  y2_pos = y1_pos - (hole_y_size + spacing);
  // Raised Line: 7mm below the second row. We calculate its center.
  y_line_pos = y2_pos - (hole_y_size / 2) - spacing - (raised_line_thickness / 2);
  // Row 3: 7mm below the raised line.
  y3_pos = y_line_pos - (raised_line_thickness / 2) - spacing - (hole_y_size / 2);

  // Use a difference to subtract the holes from the backing.
  // The holes are translated to their calculated positions.
  difference() {
    // The main backing cube.
    cube([175, 200, 8], center = true);

    translate([20, 40, 0]) {
      // Subtract Row 1 (4 holes)
      for(i = [0:5]) {
        translate([x_start + i * (hole_x_size + spacing) - 17, y1_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing) - 17, y2_pos - 4, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [1:2]) {
        translate([x_start + i * (hole_x_size + spacing) + -90, y2_pos - 5, 0]) {
          hole();
        }
      }

      // Subtract Row 3 (5 holes).
      // The last row has an additional hole to the left.
      // The new starting x position for the 5 holes is calculated.
      x_start_row3 = -((5 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);
      for(i = [0:6]) {
        for(j = [0:5]) {
          translate([x_start_row3 + i * (hole_x_size + spacing), y3_pos - j * 25, 0]) {
            hole();
          }
        }
      }
    }
  }
  // Now, add the raised line using a union.
  union() {
    translate([-40, 75, 2]) {
      color("yellow") {
        division_line();
      }
      color("magenta") {
        translate([-42, -8, -5])
          placeholder();
      }
      for(i = [0:7])
        color("magenta") {
          translate([12, 18 - 25 * i, -5])
            placeholder();
        }
             for(i = [2,4,6])
        color("magenta") {
          translate([-5, 18 - 25 * i, -5])
            rotate([0,90,270])operation_symbol_subtract_nemeth();
       }

      for(i = [0:3])
        translate([0, i * -50, 0])
          color("yellow") {
            cube(size = [125, raised_line_thickness, 3]);
          }

    }
  }
}
// A module for the raised line.
module division_line() {
  $fn = 12;
  // The raised line has the same width as the rows of holes.
  cube(size = [125, raised_line_thickness, 3]);
  translate([-8, -16, 0])
    scale([.75, .75, 1]) {
      difference() {
        cylinder(3, 25, 25);
        translate([0, 0, -1])
          cylinder(5, 22, 22);
        translate([0, -40, -3])
          rotate([0, 0, 65])
            color("red") {
              cube([50, 50, 50]);
            }
        translate([-40, 0, -3])
          cube([50, 50, 50]);
        translate([-20, -60, -3])
          cube([50, 50, 50]);

      }
    }
}


module time_keeping_UEB() {
  difference() {
    cube([100, 75, 8], center = true);
    translate([25, 30, 0])
      hole();
    translate([05, 30, 0])
      hole();
    translate([-40, 30, 0])
      hole();
    translate([-20, 30, 0])
      hole();

    translate([25, 5, 0])
      hole();
    translate([05, 5, 0])
      hole();
    translate([-40, 5, 0])
      hole();
    translate([-20, 5, 0])
      hole();

    translate([25, -20, 0])
      hole();
    translate([05, -20, 0])
      hole();
    translate([-40, -20, 0])
      hole();
    translate([-20, -20, 0])
      hole();
  }
  translate([-2, -4, 0])
    color("yellow") {
      linear_extrude(5, $fn = 12) {
        text(":", size = 10, font = "Arial");
      }
    }
  translate([-2, -29, 0])
    color("yellow") {
      linear_extrude(5, $fn = 12) {
        text(":", size = 10, font = "Arial");
      }
    }
  translate([-2, 22, 0])
    color("yellow") {
      linear_extrude(5, $fn = 12) {
        text(":", size = 10, font = "Arial");
      }
    }

}





/* PRINT VERSIONS */
module operation_symbol_multiply_print() {
  chars = ["", ""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0]) {
      UEB_str(chars, char_count);
    }
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" x", font = "Arial", size = 8);
    }
  }
}

module operation_symbol_subtract_print() {
  chars = ["", ""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" -", font = "Arial", size = 8);
    }
  }
}

module operation_symbol_add_print() {
  chars = ["", ""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" +", font = "Arial", size = 8);
    }
  }
}

module numbers_1_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 1", font = "Arial", size = 8);
    }
  }
}
module numbers_2_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 2", font = "Arial", size = 8);
    }
  }
}
module numbers_3_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 3", font = "Arial", size = 8);
    }
  }
}
module numbers_4_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 4", font = "Arial", size = 8);
    }
  }
}
module numbers_5_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 5", font = "Arial", size = 8);
    }
  }
}
module numbers_6_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 6", font = "Arial", size = 8);
    }
  }
}
module numbers_7_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 7", font = "Arial", size = 8);
    }
  }
}
module numbers_8_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 8", font = "Arial", size = 8);
    }
  }
}
module numbers_9_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 9", font = "Arial", size = 8);
    }
  }
}
module numbers_0_print() {
  chars = [""];
  // number of characters. Increase for blank space on the plate
  char_count = 2;

  union() {

    rotate([0, 270, 0])
      UEB_str(chars, char_count);
    rotate([90, 180, 270]) {
      translate([-3,-09,6])linear_extrude(2)text(" 0", font = "Arial", size = 8);
    }
  }
}


// The main module that generates the final object.
module add_subtract_print() {
  // Start with the main backing plate, centered.
  //cube([100, 100, 5], center = true);

  // Calculate the horizontal start position for the holes to ensure they are centered.
  // The total width of 4 holes with 3 spaces is: 4*10 + 3*7 = 61.
  // Since the backing is 100 wide and centered, the holes will be centered as well.
  // The offset to the first hole's center is calculated here.
  x_start = -((3 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);

  // Calculate the vertical (Y) positions for the rows and the raised line.
  // These are relative to the center of the backing plate.
  // Row 1: Positioned in the upper half.
  y1_pos = 15;
  // Row 2: Directly below Row 1, with a gap equal to the hole height plus spacing.
  y2_pos = y1_pos - (hole_y_size + spacing);
  // Raised Line: 7mm below the second row. We calculate its center.
  y_line_pos = y2_pos - (hole_y_size / 2) - spacing - (raised_line_thickness / 2);
  // Row 3: 7mm below the raised line.
  y3_pos = y_line_pos - (raised_line_thickness / 2) - spacing - (hole_y_size / 2);

  // Use a difference to subtract the holes from the backing.
  // The holes are translated to their calculated positions.
  difference() {
    // The main backing cube.
    cube([100, 100, 8], center = true);

    translate([0, 15, 0]) {
      // Subtract Row 1 (4 holes)
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y1_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0]) {
        translate([x_start + i * (hole_x_size + spacing) - 25, y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 3 (5 holes).
      // The last row has an additional hole to the left.
      // The new starting x position for the 5 holes is calculated.
      x_start_row3 = -((5 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);
      for(i = [0:4]) {
        translate([x_start_row3 + i * (hole_x_size + spacing), y3_pos, 0]) {
          hole();
        }
      }
    }
  }

  // Now, add the raised line using a union.
  union() {
    translate([-50, -10, 2]) {
      color("yellow") {
        cube([100, raised_line_thickness, 3]);
      }

    }
  }
}

// The main module that generates the final object.
module multiplication_print() {
  // Start with the main backing plate, centered.
  //cube([100, 100, 5], center = true);

  // Calculate the horizontal start position for the holes to ensure they are centered.
  // The total width of 4 holes with 3 spaces is: 4*10 + 3*7 = 61.
  // Since the backing is 100 wide and centered, the holes will be centered as well.
  // The offset to the first hole's center is calculated here.
  x_start = -((3 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);

  // Calculate the vertical (Y) positions for the rows and the raised line.
  // These are relative to the center of the backing plate.
  // Row 1: Positioned in the upper half.
  y1_pos = 55;
  // Row 2: Directly below Row 1, with a gap equal to the hole height plus spacing.
  y2_pos = y1_pos - (hole_y_size + spacing);
  // Raised Line: 7mm below the second row. We calculate its center.
  y_line_pos = y2_pos - (hole_y_size / 2) - spacing - (raised_line_thickness / 2);
  // Row 3: 7mm below the raised line.
  y3_pos = y_line_pos - (raised_line_thickness / 2) - spacing - (hole_y_size / 2);

  // Use a difference to subtract the holes from the backing.
  // The holes are translated to their calculated positions.
  difference() {
    // The main backing cube.
    cube([175, 150, 8], center = true);

    translate([20, 15, 0]) {
      // Subtract Row 1 (4 holes)
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y1_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing), y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0]) {
        translate([x_start + i * (hole_x_size + spacing) - 25, y2_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 3 (5 holes).
      // The last row has an additional hole to the left.
      // The new starting x position for the 5 holes is calculated.
      x_start_row3 = -((5 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);
      for(i = [0:4]) {
        translate([x_start_row3 + i * (hole_x_size + spacing), y3_pos, 0]) {
          hole();
        }
      }
      for(i = [0:5]) {
        translate([x_start_row3 + i * (hole_x_size + spacing) - 18, y3_pos - 25, 0]) {
          hole();
        }
      }
      for(i = [0:6]) {
        translate([x_start_row3 + i * (hole_x_size + spacing) - 35, y3_pos - 50, 0]) {
          hole();
        }
      }
      for(i = [0:7]) {
        translate([x_start_row3 + i * (hole_x_size + spacing) - 52, y3_pos - 75, 0]) {
          hole();
        }
      }
    }
  }

  union() {
    translate([-40, 75, 2]) {
      for(i = [1:2])
        translate([0, i * -50, 0])
          color("yellow") {
            cube(size = [125, raised_line_thickness, 3]);
          }
    }
  }
}
module division_print() {
  // Calculate the horizontal start position for the holes to ensure they are centered.
  // The total width of 4 holes with 3 spaces is: 4*10 + 3*7 = 61.
  // Since the backing is 100 wide and centered, the holes will be centered as well.
  // The offset to the first hole's center is calculated here.
  x_start = -((3 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);

  // Calculate the vertical (Y) positions for the rows and the raised line.
  // These are relative to the center of the backing plate.
  // Row 1: Positioned in the upper half.
  y1_pos = 55;
  // Row 2: Directly below Row 1, with a gap equal to the hole height plus spacing.
  y2_pos = y1_pos - (hole_y_size + spacing);
  // Raised Line: 7mm below the second row. We calculate its center.
  y_line_pos = y2_pos - (hole_y_size / 2) - spacing - (raised_line_thickness / 2);
  // Row 3: 7mm below the raised line.
  y3_pos = y_line_pos - (raised_line_thickness / 2) - spacing - (hole_y_size / 2);

  // Use a difference to subtract the holes from the backing.
  // The holes are translated to their calculated positions.
  difference() {
    // The main backing cube.
    cube([175, 200, 8], center = true);

    translate([20, 40, 0]) {
      // Subtract Row 1 (4 holes)
      for(i = [0:5]) {
        translate([x_start + i * (hole_x_size + spacing) - 17, y1_pos, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [0:3]) {
        translate([x_start + i * (hole_x_size + spacing) - 17, y2_pos - 4, 0]) {
          hole();
        }
      }

      // Subtract Row 2 (4 holes), positioned below Row 1.
      for(i = [1:2]) {
        translate([x_start + i * (hole_x_size + spacing) + -90, y2_pos - 5, 0]) {
          hole();
        }
      }

      // Subtract Row 3 (5 holes).
      // The last row has an additional hole to the left.
      // The new starting x position for the 5 holes is calculated.
      x_start_row3 = -((5 * (hole_x_size + spacing) + hole_x_size - 10) / 2) + (hole_x_size / 2);
      for(i = [0:6]) {
        for(j = [0:5]) {
          translate([x_start_row3 + i * (hole_x_size + spacing), y3_pos - j * 25, 0]) {
            hole();
          }
        }
      }
    }
  }
  // Now, add the raised line using a union.
  union() {
    translate([-40, 75, 2]) {
      color("yellow") {
        division_line();
      }
      for(i = [0:3])
        translate([0, i * -50, 0])
          color("yellow") {
            cube(size = [125, raised_line_thickness, 3]);
          }
             for(i = [2,4,6])
        color("magenta") {
          translate([10, 7.5 - 25 * i, 3])
            rotate([180,00,180])linear_extrude(2)text("-");
       }
    }
  }
}
// A module for the raised line.
module division_line() {
  $fn = 12;
  // The raised line has the same width as the rows of holes.
  cube(size = [125, raised_line_thickness, 3]);
  translate([-8, -16, 0])
    scale([.75, .75, 1]) {
      difference() {
        cylinder(3, 25, 25);
        translate([0, 0, -1])
          cylinder(5, 22, 22);
        translate([0, -40, -3])
          rotate([0, 0, 65])
            color("red") {
              cube([50, 50, 50]);
            }
        translate([-40, 0, -3])
          cube([50, 50, 50]);
        translate([-20, -60, -3])
          cube([50, 50, 50]);

      }
    }
}

module time_keeping_print() {
  difference() {
    cube([100, 75, 8], center = true);
    translate([25, 30, 0])
      hole();
    translate([05, 30, 0])
      hole();
    translate([-40, 30, 0])
      hole();
    translate([-20, 30, 0])
      hole();

    translate([25, 5, 0])
      hole();
    translate([05, 5, 0])
      hole();
    translate([-40, 5, 0])
      hole();
    translate([-20, 5, 0])
      hole();

    translate([25, -20, 0])
      hole();
    translate([05, -20, 0])
      hole();
    translate([-40, -20, 0])
      hole();
    translate([-20, -20, 0])
      hole();
  }
  translate([-2, -4, 0])
    color("yellow") {
      linear_extrude(5, $fn = 12) {
        text(":", size = 10, font = "Arial");
      }
    }
  translate([-2, -29, 0])
    color("yellow") {
      linear_extrude(5, $fn = 12) {
        text(":", size = 10, font = "Arial");
      }
    }
  translate([-2, 22, 0])
    color("yellow") {
      linear_extrude(5, $fn = 12) {
        text(":", size = 10, font = "Arial");
      }
    }
}

module storage_bay() {
  translate([-2,-3,0])color("yellow"){
  cube([234, 174, 2], center = false);
  }
  difference() {
    cube([230, 170, 7], center = false);
    translate([115,87,0]){for(i = [-6:6]) {
     for(j = [-6:6]) {
        translate([17 * i - 7, j * 12, 3]) {
          hole();
        }
      }
	  }
    }
  }
  }

// =====================
// Storage Bay Case (lid)
// =====================
module storage_bay_case() {
    difference() {
        // Outer box for lid
        cube([234,200,11], center=false);
        // Hollow interior
        translate([2,2,0]){ cube([230,196,10], center=false);}
}
}




// =====================
// UEB Word/Sentence Board
// Four rows, same thirteen-column layout and hole spacing as storage_bay.
// =====================
module storage_bay_words() {
  translate([-2, -3, 0])
    color("yellow")
      cube([234, 174, 2], center = false);

  difference() {
    cube([230, 170, 7], center = false);

    // Thirteen columns (i=-6..6), four centered rows.
    translate([115, 87, 0]) {
      for (i = [-6:6]) {
        for (j = [-2:1]) {
          translate([17 * i - 7, (j + 0.5) * 12, 3])
            hole();
        }
      }
    }
  }
}

// Matching shallow lid for the four-row word/sentence board.
module storage_bay_words_case() {
  difference() {
    cube([234, 200, 11], center = false);
    translate([2, 2, 0])
      cube([230, 196, 10], center = false);
  }
}

// ===== CUSTOMIZER RENDERING LOGIC =====

if (component == "time_keeping_UEB") {
  time_keeping_UEB();
} else if (component == "add_subtract_UEB") {
  add_subtract_UEB();
} else if (component == "division_UEB") {
  division_UEB();
} else if (component == "multiplication_UEB") {
  multiplication_UEB();
} else if (component == "storage_bay") {
  storage_bay();
} else if (component == "storage_bay_case") {
  storage_bay_case();
} else if (component == "storage_bay_words") {
  storage_bay_words();
} else if (component == "storage_bay_words_case") {
  storage_bay_words_case();
} else if (component == "letters_a_UEB") {
  letters_a_UEB();
} else if (component == "letters_b_UEB") {
  letters_b_UEB();
} else if (component == "letters_c_UEB") {
  letters_c_UEB();
} else if (component == "letters_d_UEB") {
  letters_d_UEB();
} else if (component == "letters_e_UEB") {
  letters_e_UEB();
} else if (component == "letters_f_UEB") {
  letters_f_UEB();
} else if (component == "letters_g_UEB") {
  letters_g_UEB();
} else if (component == "letters_h_UEB") {
  letters_h_UEB();
} else if (component == "letters_i_UEB") {
  letters_i_UEB();
} else if (component == "letters_j_UEB") {
  letters_j_UEB();
} else if (component == "letters_k_UEB") {
  letters_k_UEB();
} else if (component == "letters_l_UEB") {
  letters_l_UEB();
} else if (component == "letters_m_UEB") {
  letters_m_UEB();
} else if (component == "letters_n_UEB") {
  letters_n_UEB();
} else if (component == "letters_o_UEB") {
  letters_o_UEB();
} else if (component == "letters_p_UEB") {
  letters_p_UEB();
} else if (component == "letters_q_UEB") {
  letters_q_UEB();
} else if (component == "letters_r_UEB") {
  letters_r_UEB();
} else if (component == "letters_s_UEB") {
  letters_s_UEB();
} else if (component == "letters_t_UEB") {
  letters_t_UEB();
} else if (component == "letters_u_UEB") {
  letters_u_UEB();
} else if (component == "letters_v_UEB") {
  letters_v_UEB();
} else if (component == "letters_w_UEB") {
  letters_w_UEB();
} else if (component == "letters_x_UEB") {
  letters_x_UEB();
} else if (component == "letters_y_UEB") {
  letters_y_UEB();
} else if (component == "letters_z_UEB") {
  letters_z_UEB();
} else if (component == "letters_space_UEB") {
  letters_space_UEB();
} else if (component == "letters_a_print") {
  letters_a_print();
} else if (component == "letters_b_print") {
  letters_b_print();
} else if (component == "letters_c_print") {
  letters_c_print();
} else if (component == "letters_d_print") {
  letters_d_print();
} else if (component == "letters_e_print") {
  letters_e_print();
} else if (component == "letters_f_print") {
  letters_f_print();
} else if (component == "letters_g_print") {
  letters_g_print();
} else if (component == "letters_h_print") {
  letters_h_print();
} else if (component == "letters_i_print") {
  letters_i_print();
} else if (component == "letters_j_print") {
  letters_j_print();
} else if (component == "letters_k_print") {
  letters_k_print();
} else if (component == "letters_l_print") {
  letters_l_print();
} else if (component == "letters_m_print") {
  letters_m_print();
} else if (component == "letters_n_print") {
  letters_n_print();
} else if (component == "letters_o_print") {
  letters_o_print();
} else if (component == "letters_p_print") {
  letters_p_print();
} else if (component == "letters_q_print") {
  letters_q_print();
} else if (component == "letters_r_print") {
  letters_r_print();
} else if (component == "letters_s_print") {
  letters_s_print();
} else if (component == "letters_t_print") {
  letters_t_print();
} else if (component == "letters_u_print") {
  letters_u_print();
} else if (component == "letters_v_print") {
  letters_v_print();
} else if (component == "letters_w_print") {
  letters_w_print();
} else if (component == "letters_x_print") {
  letters_x_print();
} else if (component == "letters_y_print") {
  letters_y_print();
} else if (component == "letters_z_print") {
  letters_z_print();
} else if (component == "letters_space_print") {
  letters_space_print();
} else if (component == "operation_symbol_multiply_UEB") {
  operation_symbol_multiply_UEB();
} else if (component == "operation_symbol_add_UEB") {
  operation_symbol_add_UEB();
} else if (component == "operation_symbol_subtract_UEB") {
  operation_symbol_subtract_UEB();
} else if (component == "numbers_1_UEB") {
  numbers_1_UEB();
} else if (component == "numbers_2_UEB") {
  numbers_2_UEB();
} else if (component == "numbers_3_UEB") {
  numbers_3_UEB();
} else if (component == "numbers_4_UEB") {
  numbers_4_UEB();
} else if (component == "numbers_5_UEB") {
  numbers_5_UEB();
} else if (component == "numbers_6_UEB") {
  numbers_6_UEB();
} else if (component == "numbers_7_UEB") {
  numbers_7_UEB();
} else if (component == "numbers_8_UEB") {
  numbers_8_UEB();
} else if (component == "numbers_9_UEB") {
  numbers_9_UEB();
} else if (component == "numbers_0_UEB") {
  numbers_0_UEB();
} else if (component == "time_keeping_print") {
  time_keeping_print();
} else if (component == "add_subtract_print") {
  add_subtract_print();
} else if (component == "division_print") {
  division_print();
} else if (component == "multiplication_print") {
  multiplication_print();
} else if (component == "operation_symbol_multiply_print") {
  operation_symbol_multiply_print();
} else if (component == "operation_symbol_add_print") {
  operation_symbol_add_print();
} else if (component == "operation_symbol_subtract_print") {
  operation_symbol_subtract_print();
} else if (component == "division_Nemeth") {
  division_Nemeth();
} else if (component == "operation_symbol_multiply_nemeth") {
  operation_symbol_multiply_nemeth();
} else if (component == "operation_symbol_add_nemeth") {
  operation_symbol_add_nemeth();
} else if (component == "operation_symbol_subtract_nemeth") {
  operation_symbol_subtract_nemeth();
} else if (component == "numbers_1_print") {
  numbers_1_print();
} else if (component == "numbers_2_print") {
  numbers_2_print();
} else if (component == "numbers_3_print") {
  numbers_3_print();
} else if (component == "numbers_4_print") {
  numbers_4_print();
} else if (component == "numbers_5_print") {
  numbers_5_print();
} else if (component == "numbers_6_print") {
  numbers_6_print();
} else if (component == "numbers_7_print") {
  numbers_7_print();
} else if (component == "numbers_8_print") {
  numbers_8_print();
} else if (component == "numbers_9_print") {
  numbers_9_print();
} else if (component == "numbers_0_print") {
  numbers_0_print();
} else if (component == "numbers_1_nemeth") {
  numbers_1_nemeth();
} else if (component == "numbers_2_nemeth") {
  numbers_2_nemeth();
} else if (component == "numbers_3_nemeth") {
  numbers_3_nemeth();
} else if (component == "numbers_4_nemeth") {
  numbers_4_nemeth();
} else if (component == "numbers_5_nemeth") {
  numbers_5_nemeth();
} else if (component == "numbers_6_nemeth") {
  numbers_6_nemeth();
} else if (component == "numbers_7_nemeth") {
  numbers_7_nemeth();
} else if (component == "numbers_8_nemeth") {
  numbers_8_nemeth();
} else if (component == "numbers_9_nemeth") {
  numbers_9_nemeth();
} else if (component == "numbers_0_nemeth") {
  numbers_0_nemeth();
} else if (component == "numbers_null") {
  numbers_null();
}
