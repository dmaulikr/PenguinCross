//
//  Shader.vsh
//  deleteme
//
//  Created by Lee Irvine on 8/25/12.
//  Copyright (c) 2012 Lee Irvine. All rights reserved.
//

attribute vec4 vert;
attribute vec3 normal;
attribute vec2 tvert;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;
uniform vec3 camera;

varying vec3 fnormal;
varying vec3 fposition;
varying vec2 ftvert;

void main() {
  fnormal = normal * normalMatrix;
  fposition = vec3(modelViewMatrix * vert);
  ftvert = tvert;
  
  gl_Position = modelViewProjectionMatrix * vert;
}
