
import 'dart:ui';

import 'package:flutter/material.dart';

const double cornerRadius = 8.0;
const double moveInterval = .5;


/// 背景颜色
const Color bgColor1 = Color(0xFFFAF8EF);
const Color bgColor2 = Color.fromRGBO(182,173,156,1);
const Color bgColor3 = Color(0xFF8F7B65);


const Color whiteText = Color.fromARGB(255, 246, 240, 229);
const Color lightBrown = Color.fromARGB(255, 236, 224, 208);
const Color numCardColor = Color.fromRGBO(187,176,160,1);
const Color newGameColor = Color.fromARGB(255, 147, 131, 117);
const Color orange = Color.fromARGB(255, 245, 149, 99);
const Color tileColor = Color.fromRGBO(203,197,178,1);

const Color tan = Color.fromARGB(255, 238, 235, 218);
const Color numColor = Color.fromARGB(255, 119, 110, 101);
const Color greyText = Color.fromARGB(255, 119, 110, 101);





const Map<int, Color> numTileColor = {
  0: Color.fromRGBO(203,197,178,1),
  2: tan,
  4: tan,
  8: Color.fromARGB(255, 242, 177, 121),
  16: Color.fromARGB(255, 245, 149, 99),
  32: Color.fromARGB(255, 246, 124, 95),
  64: const Color.fromARGB(255, 246, 95, 64),
  128: const Color.fromARGB(255, 235, 208, 117),
  256: const Color.fromARGB(255, 237, 203, 103),
  512: const Color.fromARGB(255, 236, 201, 85),
  1024: const Color.fromARGB(255, 229, 194, 90),
  2048: const Color.fromARGB(255, 232, 192, 70),
};

const Map<int, Color> numTextColor = {
  0: Color.fromRGBO(0, 0, 0, 0),
  2: greyText,
  4: greyText,
  8: Colors.white,
  16: Colors.white,
  32: Colors.white,
  64: Colors.white,
  128: Colors.white,
  256: Colors.white,
  512: Colors.white,
  1024: Colors.white,
  2048: Colors.white,
};
