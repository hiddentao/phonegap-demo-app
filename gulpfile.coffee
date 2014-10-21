gulp = require('gulp')
replace = require('gulp-replace-task')
server = require('gulp-server-livereload')

liveReloadHost = require('ip').address()
liveReloadPort = 3000


gulp.task 'assets', ->
  gulp.src( [ './src/css/*.*', './src/js/*.*', './src/img/*.*' ], { base: './src' })
    .pipe( gulp.dest './www' )


gulp.task 'page', ->
  gulp.src( [ './src/index.html' ])
    .pipe( replace({
      patterns: [
        {
          match: /<head>/
          replacement: "
            <head>
            <script type=\"text/javascript\">
                var __devSite = 'http://#{liveReloadHost}:#{liveReloadPort}';
                if (window.location.origin !== __devSite) {
                  window.location = __devSite;
                }
            </script>
          "
        }
      ]
    }))
    .pipe( gulp.dest './www' )


gulp.task 'livereload', ['assets', 'page'], ->
  gulp.src [ './platforms/android/assets/www' ]
    .pipe server(
      livereload: true
      directoryListing: false
      open: false
      host: liveReloadHost
      port: liveReloadPort
      log: 'debug'
    )


gulp.task 'default', ['livereload']
