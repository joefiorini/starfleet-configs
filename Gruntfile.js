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

  grunt.registerTask('push', 'Push all packages in dist to S3', ['s3:master']);
  grunt.registerTask('release', 'Bump versions and push to S3', ['bump', 'push']);
  grunt.registerTask('package', 'Build packages', ['clean', 'compress']);
};
