import 'package:flutter/material.dart';

class CustomBoxShadow extends BoxShadow {
	final BlurStyle blurStyle;
	
	CustomBoxShadow({
		Color color = const Color(0xFF000000),
		Offset offset = Offset.zero,
		double blurRadius = 0.0,
		this.blurStyle = BlurStyle.normal,
		double spreadRadius = 1.0,
	}) : super(color: color, offset: offset, blurRadius: blurRadius, spreadRadius: spreadRadius);
	
	@override
	Paint toPaint() {
		final Paint result = Paint()
			..color = color
			..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
		assert(() {
			if (debugDisableShadows)
				result.maskFilter = null;
			return true;
		}());
		return result;
	}
}