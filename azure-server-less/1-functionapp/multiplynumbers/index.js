module.exports = async function (context, req) {
  context.log("JavaScript HTTP trigger function processed a request.");

  if (req.query.num1 && req.query.num2) {
    context.log("Inputs are valid");
    context.res = {
      // status: 200, /* Defaults to 200 */
      body: "Result is " + req.query.num1 * req.query.num2,
    };
    context.log("completed if block");
  } else {
    context.log("inputs are not valid");
    context.res = {
      status: 400 /* Defaults to 200 */,
      body: "Pass two numbers (num1 and num2) as query parameters",
    };
    context.log("completed else block");
  }
};
