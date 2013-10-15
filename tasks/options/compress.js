function imageConfig(image) {
  return {
    options: {
      archive: 'dist/configs-' + image + '-<%= pkg.version %>.tar.gz',
      mode: 'tgz'
    },
    files: [{
      expand: true,
      cwd: 'images/' + image,
      src: ['**/*'],
      dot: true
    }]
  };
}

module.exports = {
  base: imageConfig('base'),
  ruby: imageConfig('ruby'),
  go: imageConfig('go')
};
