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
uniform highp vec4 tint;
varying highp vec3 fnormal;
varying highp vec3 fposition;
varying highp vec2 ftvert;

void main() {
  mediump vec3 N = normalize(cross(dFdy(fposition), dFdx(fposition)));
	mediump vec3 V = normalize(fposition);
	mediump vec3 R = reflect(V, N);
	mediump vec3 L = normalize(camera);
  
  lowp float specular_s = 0.9;
	highp vec3 specular = vec3(specular_s,specular_s,specular_s) * max(dot(R, L), 0.0);
  
	gl_FragColor = texture2D(texture, ftvert) * vec4(specular, 1.0) * tint;
}

