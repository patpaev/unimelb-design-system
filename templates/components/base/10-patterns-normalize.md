## Normalize

A very basic style reset included before all else. Included automatically.

```scss
html,
body {
  margin: 0;
  padding: 0;
  height: 100%;
}
body {
  font-size: 1em;
  -webkit-font-smoothing: antialiased;
  line-height: 1.6;
  margin: 0;
  padding: 0;
  position: relative;
  perspective: 1500px;
  -webkit-perspective: 1500px;
  perspective-origin: 0% 50%;
  -webkit-perspective-origin: 0% 50%;
  text-rendering: optimizeLegibility;
}
h1,
h2,
h3,
h4,
h5,
p,
li {
  margin: 0;
  padding: 0;
}
iframe[src^='//www.youtube.com'],
iframe[src^='//player.vimeo.com'] {
  width: 100%;
}
```