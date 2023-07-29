// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "chartkick/chart.js"

import * as bootstrap from "bootstrap"

import $ from 'jquery'
import { Tooltip } from "bootstrap"

$('[data-bs-toggle="tooltip"]').each((idx, elm) => {
  new Tooltip(elm)
})
