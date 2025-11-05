# Vital Signs (Vega-Lite JSON)

> Source: `vital-signs.vl.json`. Until CI exports images, view JSON here.

```json
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "width": 900,
  "height": 420,
  "data": {
    "values": [
      {
        "v": 25.0,
        "t": 1800,
        "k": "LifeExpectancy"
      },
      {
        "v": 31.0,
        "t": 1900,
        "k": "LifeExpectancy"
      },
      {
        "v": 67.0,
        "t": 2000,
        "k": "LifeExpectancy"
      },
      {
        "v": 72.0,
        "t": 2020,
        "k": "LifeExpectancy"
      },
      {
        "v": 12.0,
        "t": 1800,
        "k": "Literacy"
      },
      {
        "v": 21.0,
        "t": 1900,
        "k": "Literacy"
      },
      {
        "v": 82.0,
        "t": 2000,
        "k": "Literacy"
      },
      {
        "v": 86.0,
        "t": 2020,
        "k": "Literacy"
      },
      {
        "v": 5.0,
        "t": 1800,
        "k": "ExtremePovertyInv"
      },
      {
        "v": 8.0,
        "t": 1900,
        "k": "ExtremePovertyInv"
      },
      {
        "v": 85.0,
        "t": 2000,
        "k": "ExtremePovertyInv"
      },
      {
        "v": 92.0,
        "t": 2020,
        "k": "ExtremePovertyInv"
      }
    ]
  },
  "layer": [
    {
      "encoding": {
        "color": {
          "type": "nominal",
          "title": "Series",
          "field": "k"
        },
        "x": {
          "scale": {
            "nice": false
          },
          "type": "quantitative",
          "title": "Year",
          "field": "t"
        },
        "y": {
          "scale": {
            "domain": [
              0,
              100
            ]
          },
          "type": "quantitative",
          "title": "Normalized index (0–100)",
          "field": "v"
        },
        "opacity": {
          "value": 0.6
        }
      },
      "mark": {
        "type": "line"
      }
    },
    {
      "transform": [
        {
          "groupby": [
            "t"
          ],
          "aggregate": [
            {
              "op": "mean",
              "as": "Vitality",
              "field": "v"
            }
          ]
        }
      ],
      "encoding": {
        "color": {
          "value": "black"
        },
        "x": {
          "type": "quantitative",
          "field": "t"
        },
        "y": {
          "type": "quantitative",
          "field": "Vitality"
        }
      },
      "mark": {
        "type": "line",
        "strokeWidth": 4
      }
    }
  ]
}

```

