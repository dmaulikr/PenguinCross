//
//  Fragment Shader
//  Penguin Cross
//
//  Created by Lee Irvine on 8/25/12.
//  Copyright (c) 2012 Lee Irvine. All rights reserved.
//

#extension GL_OES_standard_derivatives : enable

uniform mediump vec3 camera;
uniform sampler2D texture;
uniform int ticks;

uniform mediump vec4 tint;
varying mediump vec3 fnormal;
varying mediump vec3 fposition;
varying mediump vec2 ftvert;

void main() {
  mediump vec3 N = normalize(cross(dFdy(fposition), dFdx(fposition)));
	mediump vec3 V = normalize(fposition);
	mediump vec3 R = reflect(V, N);
	mediump vec3 L = normalize(camera);
  
  lowp float o = cos(float(ticks) * 3.141 / 30.0) * 0.4;
  lowp float specular_s = 1.2 + o;
  
	highp vec3 specular = vec3(specular_s,specular_s,specular_s) * max(dot(R, L), 0.0);
  
	gl_FragColor = texture2D(texture, ftvert) * vec4(specular, 1.0) * tint;
}

