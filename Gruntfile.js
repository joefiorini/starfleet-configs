module.exports = function(grunt) {

  require("load-grunt-tasks")(grunt);

  grunt.initConfig({
    aws: grunt.file.readJSON(process.env.HOME + '/grunt-aws.json'),
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
    s3: {
      options: {
        key: '<%= aws.key %>',
        secret: '<%= aws.secret %>',
        access: 'public-read',
        bucket: 'configs.static.triforce.io'
      },
      master: {
        upload: [{
          src: '_dist/configs-*.tar.gz'
        }]
      }
    },
    bump: {
      options: {
        files: ['package.json'],
        commitMessage: 'Release v%VERSION%. Woot. :tada:',
        pushTo: 'origin',
        updateConfigs: ['pkg']
      }
    },
    clean: ['_dist']
  });

  grunt.registerTask('push', ['s3:master']);
  grunt.registerTask('release', ['bump', 'push']);
  grunt.registerTask('package', ['clean', 'compress']);
};
