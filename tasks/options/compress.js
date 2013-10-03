module.exports = {
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
};
