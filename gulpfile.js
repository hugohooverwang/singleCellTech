const gulp = require('gulp'),
      sh = require('shelljs'),
      rename = require('gulp-rename'),
      del = require('del');

const paths = {
  org: {
    src: './orgmode/kinesiska/*.org',
    dest: './orgmode/translation/source'
  },
  txt: {
    src: './orgmode/translation/target/*.txt',
    dest: './orgmode/engelska'
  },
  md: {
    src: './orgmode/engelska/*.md',
    dest: './docs/utkast'
  }
}

// function clean() {
//   return del(['omegat-src', 'omegat-target']);
// }

function totxt() {
  return gulp.src(paths.org.src)
    .pipe(rename({
      extname: '.txt'
    }))
    .pipe(gulp.dest(paths.org.dest));
}

function toorg() {
  return gulp.src(paths.txt.src)
    .pipe(rename({
      suffix: "-en",
      extname: '.org'
    }))
    .pipe(gulp.dest(paths.txt.dest));
}

function prepost () {
  return gulp.src(paths.md.src)
    .pipe(gulp.dest(paths.md.dest));
}

function watch() {
  gulp.watch(paths.org.src, totxt);
  gulp.watch(paths.txt.src, toorg);
  gulp.watch(paths.md.src, prepost);
}

const omegat = gulp.series(totxt, toorg, prepost, watch);

exports.totxt = totxt;
exports.toorg = toorg;
exports.prepost = prepost;
exports.default = omegat
