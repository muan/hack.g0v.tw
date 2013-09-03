(function(){
  module.exports = function(config){
    return config.set({
      basePath: './',
      preprocessors: {
        '**/*.ls': ['live']
      },
      frameworks: ['mocha'],
      files: ['test/*.ls'],
      exclude: [],
      reporters: ['progress'],
      port: 9876,
      colors: true,
      logLevel: config.LOG_INFO,
      browsers: ['Chrome'],
      captureTimeout: 60000,
      singleRun: false
    });
  };
}).call(this);
