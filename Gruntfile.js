module.exports = function(grunt) {

  require("load-grunt-tasks")(grunt);

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    compress: {
      main: {
        options: {
          archive: '_dist/configs-<%= pkg.version %>.tar.gz',
          mode: 'tgz'
        },
        files: [{
          expand: true,
          src: ['**/*', '!Gruntfile.js', '!_*', '!.git/**/*', '!.git*', '!node_modules/**/*', '!tmp', '!package.json'],
          dot: true
        }]
      }
    },
    clean: ['_dist']
  });

  grunt.registerTask('package', ['clean', 'compress']);
};
