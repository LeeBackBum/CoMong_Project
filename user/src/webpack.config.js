const path = require('path');

module.exports = {
    entry: './src/main/resources/static/js/app.js', // 진입점 설정
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'src/main/resources/static/js')
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader'
                }
            }
        ]
    },
    mode: 'development'
};