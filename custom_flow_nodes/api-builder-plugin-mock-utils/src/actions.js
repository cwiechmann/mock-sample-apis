var priotizedCodes;
var priotizedTimes;

/**
 * Action method.
 *
 * @param {object} params - A map of all the parameters passed from the flow.
 * @param {object} options - The additional options provided from the flow
 *	 engine.
 * @param {object} options.pluginConfig - The service configuration for this
 *	 plugin from API Builder config.pluginConfig['api-builder-plugin-pluginName']
 * @param {object} options.logger - The API Builder logger which can be used
 *	 to log messages to the console. When run in unit-tests, the messages are
 *	 not logged.  If you wish to test logging, you will need to create a
 *	 mocked logger (e.g. using `simple-mock`) and override in
 *	 `MockRuntime.loadPlugin`.  For more information about the logger, see:
 *	 https://docs.axway.com/bundle/API_Builder_4x_allOS_en/page/logging.html
 * @param {*} [options.pluginContext] - The data provided by passing the
 *	 context to `sdk.load(file, actions, { pluginContext })` in `getPlugin`
 *	 in `index.js`.
 * @return {*} The response value (resolves to "next" output, or if the method
 *	 does not define "next", the first defined output).
 */
async function returnCode(params, options) {
	const { inputCodes } = params;
	const { logger } = options;
	if (!inputCodes) {
		throw new Error('Missing required parameter: inputCodes');
	}
	if(!priotizedCodes) {
		priotizedCodes = [];
		for (i = 0; i < inputCodes.length; i++) {
			prio = inputCodes[i]['priority'];
			for (var u = 0; u < prio; u++) {
				priotizedCodes.push(inputCodes[i]);
			}
		}
		logger.info(`Randomized returnCodes successfully initialized.`);
	}
	var randomKey = getRandomInt(0,priotizedCodes.length);
	return priotizedCodes[randomKey].code;
}

async function randomNumber(params, options) {
	const { inputTimes } = params;
	const { logger } = options;
	if (!inputTimes) {
		throw new Error('Missing required parameter: inputTimes');
	}
	if(!priotizedTimes) {
		priotizedTimes = [];
		for (i = 0; i < inputTimes.length; i++) {
			prio = inputTimes[i]['priority'];
			for (var u = 0; u < prio; u++) {
				priotizedTimes.push(inputTimes[i]);
			}
		}
		console.log(`Randomized times successfully initialized.`);
	}
	var randomKey = getRandomInt(0,priotizedTimes.length);
	var range = priotizedTimes[randomKey].range.split('-');
	return getRandomInt(range[0], range[1]);
}

function getRandomInt(min, max) {
	min = Math.ceil(min);
	max = Math.floor(max);
	return Math.floor(Math.random() * (max - min)) + min;
  }

module.exports = {
	returnCode,
	randomNumber
};
