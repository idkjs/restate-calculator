module NaiveView = View.Make(Updater.NaiveUpdater);

module StatechartView = View.Make(CalculatorState);

ReactDOMRe.renderToElementWithId(<StatechartView />, "index");

module NaiveTests = Tests.Make(Updater.NaiveUpdater);

NaiveTests.test();

module StatechartTests = Tests.Make(CalculatorState);

StatechartTests.test();
