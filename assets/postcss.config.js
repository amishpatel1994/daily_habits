
module.exports = {
  plugins: [
    require("postcss-import"),
    require("tailwindcss"),
    require("autoprefixer"),
    require("postcss-purgecss")({
      content: [
        "../**/*html.eex",
        "../**/views/*.ex",
        "./js/**.js",
      ],
      defaultExtractor: content => content.match(/[\w-/:]*(?<!:)/g) || []
    })
  ],
}
