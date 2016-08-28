Shiny.addCustomMessageHandler("jsondata",
function(message){
var json_data = message;


<svg>
  <defs>
    <filter id="tint">
      <feColorMatrix values="1.1 0 0 0 0  0 1.1 0 0 0  0 0 0.9 0 0  0 0 0 1 0" />
    </filter>
    <filter id="splotch">
      <feTurbulence type="fractalNoise" baseFrequency=".01" numOctaves="4" />
      <feColorMatrix values="0 0 0 0 0, 0 0 0 0 0, 0 0 0 0 0, 0 0 0 -0.9 1.2" result="texture" />
      <feComposite in="SourceGraphic" in2="texture" operator="in" />
      <feGaussianBlur stdDeviation="3.5" />
    </filter>
    <filter id="pencil">
      <feTurbulence baseFrequency="0.03" numOctaves="6" type="fractalNoise" />
      <feDisplacementMap scale="4" in="SourceGraphic" xChannelSelector="R" yChannelSelector="G" />
      <feGaussianBlur stdDeviation="0.5" />
    </filter>
  </defs>
</svg>
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.16/d3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/topojson/1.6.20/topojson.min.js"></script>
<script>

var width = 960,
    height = 500;

var projection = d3.geo.albers()
  .rotate([96, 0])
  .parallels([29.5, 45.5])
  .center([-0.62, 38.65])
  .scale(1065)
  .translate([width / 2, height / 2])
  .precision(.1);

var path = d3.geo.path()
  .projection(projection);

var svg = d3.select("#div_tree").append("svg")
  .attr("width", width)
  .attr("height", height)
  .append("g")
    .attr("filter", "url(#tint)");

var defs = d3.select("defs");

svg.append("rect")
  .attr("width", width)
  .attr("height", height);

var line = d3.svg.line()
  .interpolate("cardinal")
  .tension(0.75);

var colors = ["#00c65e", "#c60084", "#c6c600", "#09a3bd", "#b15313"];

d3.json("us.json", function(err, us) {

  var neighbors = topojson.neighbors(us.objects.states.geometries),
      mesh = topojson.mesh(us,us.objects.states),
      features = topojson.feature(us, us.objects.states).features;

  features.forEach(function(d,i){

    // Greedy color selection
    d.properties.color = colors.filter(function(c){
      return neighbors[i].map(function(n){
        return features[n].properties.color;
      }).indexOf(c) === -1;
    })[0];

    // Mix it up a bit, get fifth color in
    colors.push(colors.shift());

    // circular <use> doesn't work in FF
    defs.append("clipPath")
      .attr("id", "clip" + i)
      .append("path")
        .attr("d", path(d));

  });

  svg.selectAll(".state")
    .data(features)
    .enter()
    .append("path")
      .attr("class", "state")
      .attr("d", path)
      .style("fill", function(d){
        return transparent(d.properties.color, 0.3);
      })
      .style("stroke", function(d,i){
        return d.properties.color;
      })
      .attr("clip-path", function(d,i){
        return "url(#clip" + i + ")";
      })
      .attr("filter", "url(#splotch)");

  svg.append("g")
    .attr("class", "mesh")
    .attr("filter", "url(#pencil)")
    .selectAll(".path")
    .data(mesh.coordinates)
    .enter()
      .append("path")
        .attr("d", function(d){
          return line(d.map(projection));
        });

});

function transparent(color, alpha) {
  var rgb = d3.rgb(color);
  return "rgba(" + [rgb.r, rgb.g, rgb.b, alpha].join(",") + ")";
}

</script>
})