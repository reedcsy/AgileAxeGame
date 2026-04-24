// sh_white_flash.fsh
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
    // This turns all non-transparent pixels pure white
    gl_FragColor = vec4(1.0, 1.0, 1.0, texColor.a) * v_vColour;
}