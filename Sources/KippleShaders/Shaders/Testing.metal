// Copyright © 2024 Brian Drelling. All rights reserved.

#include <metal_stdlib>
using namespace metal;

// Source: https://alexanderlogan.co.uk/blog/wwdc23/09-metal
[[ stitchable ]] half4 aqua(
    float2 position,
    half4 color
) {
    // R, G, B, A
    return half4(60.0/255.0, 238.0/255.0, 227.0/255.0, 1.0);
}
