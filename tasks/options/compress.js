module.exports = {
  main: {
    options: {
      archive: 'dist/configs-<%= pkg.version %>.tar.gz',
      mode: 'tgz'
    },
    files: [{
      expand: true,
      cwd: 'src',
      src: ['**/*'],
      dot: true
    }]
  }
};
