function loadConfig(task) {
  return require('./tasks/options/' + task);
}

module.exports = function(grunt) {

  require("load-grunt-tasks")(grunt);

  grunt.initConfig({
    aws: grunt.file.readJSON(process.env.HOME + '/grunt-aws.json'),
    pkg: grunt.file.readJSON('package.json'),
    compress: loadConfig('compress'),
    s3: loadConfig('s3'),
    bump: loadConfig('bump'),
    clean: ['_dist']
  });

  grunt.registerTask('push', ['s3:master']);
  grunt.registerTask('release', ['bump', 'push']);
  grunt.registerTask('package', ['clean', 'compress']);
};
