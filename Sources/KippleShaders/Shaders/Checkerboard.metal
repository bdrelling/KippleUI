// Copyright © 2024 Brian Drelling. All rights reserved.

#include <metal_stdlib>
using namespace metal;

// Source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-metal-shaders-to-swiftui-views-using-layer-effects
[[ stitchable ]] half4 checkerboard(float2 position, half4 currentColor, float size, half4 newColor) {
    uint2 posInChecks = uint2(position.x / size, position.y / size);
    bool isColor = (posInChecks.x ^ posInChecks.y) & 1;
    return isColor ? newColor * currentColor.a : half4(0.0, 0.0, 0.0, 0.0);
}
