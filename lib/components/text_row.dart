import 'package:flutter/material.dart';

Container renderTextRow(text, color) {
  return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      color: color,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Center(child: Text(text))]));
}
