const { expect } = require('chai');
const { MockRuntime } = require('@axway/api-builder-test-utils');
const getPlugin = require('../src');

describe('flow-node mock-utils', () => {
	let plugin;
	let flowNode;
	beforeEach(async () => {
		plugin = await MockRuntime.loadPlugin(getPlugin);
		plugin.setOptions({ validateOutputs: true });
		flowNode = plugin.getFlowNode('mock-utils');
	});

	describe('#constructor', () => {
		it('should define flow-nodes', () => {
			expect(plugin).to.be.a('object');
			expect(plugin.getFlowNodeIds()).to.deep.equal([
				'mock-utils'
			]);
			expect(flowNode).to.be.a('object');

			// Ensure the flow-node matches the spec
			expect(flowNode.name).to.equal('Mock-UP Utils');
			expect(flowNode.description).to.equal('Utility flow now used to make mocked API-Calls more realistic. For instance use different return codes or response times.');
			expect(flowNode.icon).to.be.a('string');
		});

		// It is vital to ensure that the generated node flow-nodes are valid
		// for use in API Builder. Your unit tests should always include this
		// validation to avoid potential issues when API Builder loads your
		// node.
		it('should define valid flow-nodes', () => {
			// if this is invalid, it will throw and fail
			plugin.validate();
		});
	});

	describe('#hello', () => {
		it('should error when missing required parameter', async () => {
			const { value, output } = await flowNode.returnCode({
				inputCodes: null
			});

			expect(value).to.be.instanceOf(Error)
				.and.to.have.property('message', 'Missing required parameter: inputCodes');
			expect(output).to.equal('error');
		});

		it('should return 200, as the priority is 100', async () => {
			const { value, output } = await flowNode.returnCode({ 
				inputCodes: [
					{"code": 200, "priority": 100},
					{"code": 201, "priority": 1},
					{"code": 500, "priority": 1},
				] 
			});

			expect(value).to.be.a('number');
			expect(value).to.equal(200);
			expect(output).to.equal('next');
		});

		it('should return a number within the given range having priority 100', async () => {
			const { value, output } = await flowNode.randomNumber({ 
				inputTimes: [
					{"range": "10-30", "priority": 100},
					{"range": "40-80", "priority": 1},
					{"range": "90-200", "priority": 1},
				] 
			});

			expect(value).to.be.a('number');
			expect(value).to.lte(30);
			expect(value).to.gte(10);
			expect(output).to.equal('next');
		});
	});
});
