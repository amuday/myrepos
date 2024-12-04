const { app } = require("@azure/functions");
const { ImageAnalysisClient } = require("@azure-rest/ai-vision-image-analysis");
const createClient = require("@azure-rest/ai-vision-image-analysis").default;
const { AzureKeyCredential } = require("@azure/core-auth");

// Load the .env file if it exists
require("dotenv").config();

// const endpoint = process.env["VISION_ENDPOINT"];
// const key = process.env["VISION_KEY"];

const endpoint = "https://udayfunc.cognitiveservices.azure.com/";
const key = "d8a9ffa045ec417ea7dad29a31fe3dda";

const credential = new AzureKeyCredential(key);
const client = createClient(endpoint, credential);

const features = ["Caption", "Read"];

const imageUrl =
  "https://learn.microsoft.com/azure/ai-services/computer-vision/media/quickstarts/presentation.png";

app.storageBlob("image-upload", {
  path: "image-input/{name}",
  connection: "udayfunctest_STORAGE",
  handler: (blob, context) => {
    context.log(
      `Storage blob function processed blob "${context.triggerMetadata.name}" with size ${blob.length} bytes`
    );

    analyzeImageFromUrl();
  },
});

async function analyzeImageFromUrl() {
  const result = await client.path("/imageanalysis:analyze").post({
    body: {
      url: imageUrl,
    },
    queryParameters: {
      features: features,
    },
    contentType: "application/json",
  });

  const iaResult = result.body;

  if (iaResult.captionResult) {
    console.log(
      `Caption: ${iaResult.captionResult.text} (confidence: ${iaResult.captionResult.confidence})`
    );
  }
  if (iaResult.readResult) {
    iaResult.readResult.blocks.forEach((block) =>
      console.log(`Text Block: ${JSON.stringify(block)}`)
    );
  }
}
