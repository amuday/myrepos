const { app } = require("@azure/functions");

app.storageBlob("AnalyzeImageBLobTriggerCosmosOut", {
  path: "image-input/{name}",
  connection: "udayfunctest_STORAGE",
  handler: (blob, context) => {
    context.log(
      `Storage blob function processed blob "${context.triggerMetadata.name}" with size ${blob.length} bytes`
    );
  },
});
