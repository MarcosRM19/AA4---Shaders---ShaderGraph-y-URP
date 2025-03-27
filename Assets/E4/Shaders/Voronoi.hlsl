float random(float2 st)
{
    return frac(sin(dot(st.xy, float2(12.9898, 78.233))) * 43758.5453123);
}

float VoronoiDistance(float2 x)
{
    int2 p = floor(x);
    float2 f = frac(x);

    int2 mb;
    float2 mr;

    float res = 8.0;
    for (int j = -1; j <= 1; j++)
        for (int i = -1; i <= 1; i++)
        {
            int2 b = int2(i, j);
            float2 r = float2(b) + random(p + b) - f;
            float d = dot(r, r);

            if (d < res)
            {
                res = d;
                mr = r;
                mb = b;
            }
        }

    res = 8.0;
    for (int j = -2; j <= 2; j++)
        for (int i = -2; i <= 2; i++)
        {
            float2 b = mb + float2(i, j);
            float2 r = float2(b) + random(p + b) - f;
            float d = dot((mr + r), normalize(r - mr));

            res = min(res, d);
        }

    return res;
}

void getBorder_float(float2 UV, out float Out)
{
    float d = VoronoiDistance(UV);

    Out = smoothstep(0.0, 1.25, d);
}