module.exports = {
  options: {
    key: '<%= aws.key %>',
    secret: '<%= aws.secret %>',
    access: 'public-read',
    bucket: 'configs.static.triforce.io'
  },
  master: {
    upload: [{
      src: 'dist/configs-*.tar.gz'
    }]
  }
};
