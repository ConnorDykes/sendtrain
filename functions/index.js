/* eslint-disable no-unused-vars */
/* eslint-disable max-len */
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const {onCall} = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
const {genkit} = require("genkit");
const {enableFirebaseTelemetry} = require("@genkit-ai/firebase");
const {googleAI} = require("@genkit-ai/googleai");
const z = require("zod");


admin.initializeApp();
enableFirebaseTelemetry();

const ai = genkit({
  plugins: [
    googleAI({

      apiKey: process.env.GEMINI_API_KEY,
    }),
  ],
  model: googleAI.model("gemini-2.5-pro", {
    temperature: 1.0,
  }),
  logLevel: "debug",
  enableTracingAndMetrics: true,
});

// Read the prompt template
const climbingCoachPrompt = `
Your response MUST be a single, valid JSON object, without any introductory or concluding text outside of the JSON structure itself.

//-- INPUT INSTRUCTIONS --//

You will receive user data in the following JSON format. You must carefully analyze every field to inform your program design.

{
  "age": "Integer",
  "gender": "String | null ('Male', 'Female', 'Non-binary', 'Prefer not to say')",
  "climbingYears": "Float | null (e.g., 2.5)",
  "climbingDaysPerWeek": "Integer | null (Number of days available for any training)",
  "timePerSessionHours": "Float | null (Average hours available per session)",
  "climbingStylePreference": "Array of Strings | null (e.g., ['Bouldering', 'Sport', 'Trad'])",
  "boulderOnsight": "String | null (V-Scale, e.g., 'V4')",
  "boulderRedpoint": "String | null (V-Scale, e.g., 'V6')",
  "sportOnsight": "String | null (YDS, e.g., '5.10d')",
  "sportRedpoint": "String | null (YDS, e.g., '5.11c')",
  "goalDescription": "String | null (User's primary climbing goals, e.g., 'Redpoint my first 5.12a' or 'Improve finger strength to climb V7')",
  "planDurationWeeks": "Integer (Total weeks for the training plan, e.g., 8)",
  "injuries": "String | null (Details about past or current injuries, e.g., 'Recurring impingement in left shoulder.')",
  "restrictions": "String | null (e.g., 'No access to a campus board, limited to 90 minutes per session.')",
  "anythingElse": "String | null (Any other relevant information from the user)"
}

//-- CORE LOGIC & PROGRAM DESIGN INSTRUCTIONS --//

Analyze User Profile:

Experience Level: Categorize the user (Beginner, Intermediate, Advanced) based on climbingYears, and redpoint/onsight grades.

Goals: Interpret the goalDescription to identify the primary training focus (e.g., Power, Endurance, Power-Endurance, Technique).

Specificity: the pla should as specific to the users goals and ability as possible. each plan should be unique. 

Constraints: Pay strict attention to injuries, restrictions, climbingDaysPerWeek, and timePerSessionHours. Safety is paramount. If an injury is noted, you must add cautionary notes and suggest modifications or exercises to avoid.

Equipment Assumption: Since specific equipment availability is not provided, you must prescribe strength & conditioning exercises that primarily use bodyweight or standard equipment found in most commercial climbing gyms (e.g., pull-up bars, free weights, fingerboards). You must state this assumption in the programNotes section of your output.


Detail Daily Sessions:

Each training day must be an object containing a description of the training focus for that day and three distinct phases: warmUp, mainSession, and coolDown.

warmUp: Provide a comprehensive warm-up routine the is realted to the primary training focus (e.g., 5-10 minutes of cardio, dynamic stretches, muscle activation, easy climbing traverses, progressively harder boulders).

mainSession: This is the core of the workout. Provide a list of exercises or drills. Each item in the list should be an object with clear, actionable details:

coolDown: Provide a cool-down routine (e.g., 5-10 minutes of very light climbing or cardio, followed by static stretching for key muscle groups like forearms, lats, chest, and shoulders).

Handle Missing Data:

If key performance data (boulderRedpoint, sportRedpoint) is null, create a more generalized program for the user's inferred experience level from climbingYears.

Acknowledge any assumptions made due to null or missing data in the programNotes section of the output.

//-- OUTPUT JSON SCHEMA --//

// -- This is the required structure for a single Activity Object -- //
{
    "exerciseName": "String - The name of the exercise or drill.",
    "details": "String - A brief description of how to perform it.",
    "requiredEquipment": "String - Any equipment or terrain needed (e.g., 'Bouldering wall', 'Pull-up bar', 'None').",
    "sets": "String - Number of sets.",
    "reps": "String - Number of repetitions or duration (e.g., '5-8' or '30-second hold').",
    "rest": "String - Rest time between sets.",
    "intensity": "String - A measure of effort (e.g., 'Low', 'High', 'RPE 8/10', 'V-max grade').",
    "estimatedCompletionTime": "String - Estimated time in minutes to complete this specific activity.",
    "howToAdjust": "String - How to make the exercise easier or harder."
}


Your entire output must conform to this JSON structure. Do not add any extra commentary.
{
  "programTitle": "String (a simple title for the program base don the users goal)",
  "programFocus": "String (e.g., 'Bouldering Power & Finger Strength')",
  "durationWeeks": "Integer",
  "programDescripton": " String (A brief intro to the program's philosophy, structure, and goals.)",
    
  "programNotes": {
    "safetyDisclaimer": "Standard disclaimer to consult a doctor and listen to one's body.",
    "injuryModifications": "Specific adjustments based on user's injuries on ly if they have provided them",
    "assumptionsMade": "Any assumptions made due to null or missing data."
  },
  "weeklySchedule": [
    {
      "week": "Integer (e.g., 1)",
      "phase": "String (e.g., 'Strength Phase') only if phases are used in the plan",
      "weeklyFocus": "String (e.g., 'Build foundational strength and practice movement on sub-maximal climbs.')",
      "dailySessions": [
        {
          "sessionNumber": "Integer (the number of the session for that week)",
          "dayOfTheWeek": "String (e.g., 'Monday')",
          "sessionType": "String (e.g., 'Climbing & Strength')",
          "sessionFocus": "String (e.g., 'Max-Recruitment Bouldering and Antagonist Strength')",
          "warmUp": {
            "durationMinutes": "Integer",
            "exercises": [
             // Array of Activity Objects, structured as defined above.
            
            ]
          },
          "mainSession": {
            "durationMinutes": "Integer",
            "exercises": [
             // Array of Activity Objects, structured as defined above.
            ]
          },
          "coolDown": {
            "durationMinutes": "Integer",
            "activities": [
             // Array of Activity Objects, structured as defined above.            ]
          }
        },
        {
          "day": "Integer (e.g., 2)",
          "sessionType": "String (e.g., 'Rest Day')"
        }
      ]
    }
  ],
  "glossary": {
    "RPE": "Rate of Perceived Exertion, a scale from 1 (rest) to 10 (maximal effort).",
    "Limit Bouldering": "Trying boulder problems at your maximum physical limit to increase strength and neural recruitment.",
    "4x4s": "A power-endurance drill where you climb 4 boulder problems back-to-back, rest, and repeat for 4 sets.",
    "ARC": "Aerobic Restoration and Capillarity. Climbing continuously on easy terrain for 20-45 minutes to build endurance base."
  },
  "glossary": [
    {
      "term": "RPE",
      "definition": "Rate of Perceived Exertion, a scale from 1 (rest) to 10 (maximal effort)."
    },
    {
      "term": "Limit Bouldering",
      "definition": "Trying boulder problems at your maximum physical limit to increase strength and neural recruitment."
    }
  ]
}

//-- EXECUTE --//

Now, analyze the following user data and generate the personalized rock climbing training program in the specified JSON format.

[USER_JSON_INPUT]`;

// Define the Zod schema for the input based on the prompt description
const userInputSchema = z.object({
  age: z.number(),
  gender: z.string().nullable().optional(),
  climbingYears: z.string().nullable().optional(),
  climbingDaysPerWeek: z.string().nullable().optional(),
  timePerSessionHours: z.number().nullable().optional(),
  climbingStylePreference: z.array(z.string()).nullable().optional(),
  boulderOnsight: z.string().nullable().optional(),
  boulderRedpoint: z.string().nullable().optional(),
  sportOnsight: z.string().nullable().optional(),
  sportRedpoint: z.string().nullable().optional(),
  goalDescription: z.string(),
  planDurationWeeks: z.number(),
  injuries: z.string().nullable().optional(),
  restrictions: z.string().nullable().optional(),
  anythingElse: z.string().nullable().optional(),
});

// Define Zod schemas for the output JSON structure
const exerciseSchema = z.object({
  exerciseName: z.string(),
  details: z.string(),
  requiredEquipment: z.string(),
  sets: z.string(),
  reps: z.string(),
  rest: z.string(),
  intensity: z.string(),
  estimatedCompletionTime: z.string(),
  howToAdjust: z.string(),
});

const programNotesSchema = z.object({
  safetyDisclaimer: z.string(),
  injuryModifications: z.string(),
  assumptionsMade: z.string(),
});

const sessionPhaseSchema = z.object({
  durationMinutes: z.number(),
  exercises: z.array(exerciseSchema).optional(),
  activities: z.array(exerciseSchema).optional(),
});

const fullDailySessionSchema = z.object({
  sessionNumber: z.number(),
  dayOfTheWeek: z.string(),
  sessionType: z.string(),
  sessionFocus: z.string(),
  warmUp: sessionPhaseSchema,
  mainSession: sessionPhaseSchema,
  coolDown: sessionPhaseSchema,
});

const restDaySchema = z.object({
  day: z.number(),
  sessionType: z.string(),
});

const dailySessionSchema = z.union([fullDailySessionSchema, restDaySchema]);

const weeklySessionSchema = z.object({
  week: z.number(),
  phase: z.string(),
  weeklyFocus: z.string(),
  dailySessions: z.array(dailySessionSchema),
});

const glossaryItemSchema = z.object({
  term: z.string(),
  definition: z.string(),
});

const trainingProgramSchema = z.object({
  programTitle: z.string(),
  programFocus: z.string(),
  durationWeeks: z.number(),
  programDescripton: z.string(),
  programNotes: programNotesSchema,
  weeklySchedule: z.array(weeklySessionSchema),
  glossary: z.array(glossaryItemSchema),
});

const generateClimbingProgramFlow = ai.defineFlow(
    {
      name: "generateClimbingProgramFlow",
      inputSchema: userInputSchema,
      outputSchema: trainingProgramSchema,
    },
    async (userData) => {
      const fullPrompt = climbingCoachPrompt.replace(
          "[USER_JSON_INPUT]",
          JSON.stringify(userData),
      );

      const llmResponse = await ai.generate({
        system: "You are a rock climbing coach and an AI training assistant. Your primary function is to create a detailed, personalized, and safe rock climbing training program based on user-provided data. The program must be structured logically, incorporating principles of periodization to help the user systematically achieve their goals over the specified duration.",
        prompt: fullPrompt,
        config: {temperature: 1.0},
        output: {format: "json", schema: trainingProgramSchema},

      });

      const programJson = llmResponse.output;

      if (!programJson) {
        throw new Error("Failed to generate a valid program from the model.");
      }

      return programJson;
    },
);

exports.generateClimbingProgram = onCall(
    {
    // You might want to increase memory and timeout for AI-related tasks
      memory: "2GiB",
      timeoutSeconds: 540,
      enforceAppCheck: false, // Explicitly disable App Check
      secrets: ["GEMINI_API_KEY"], // Grant access to the secret
    },
    async (request) => {
      if (!request.auth) {
        // This is the security check for callable functions.
        throw new functions.https.HttpsError(
            "unauthenticated",
            "The function must be called while authenticated.",
        );
      }

      const uid = request.auth.uid;
      const data = request.data;

      // Validate data with Zod schema
      const validationResult = userInputSchema.safeParse(data);
      if (!validationResult.success) {
        // Return detailed validation errors
        console.error("Zod validation failed:", validationResult.error.format());
        throw new functions.https.HttpsError(
            "invalid-argument",
            "The data provided is not valid.",
            validationResult.error.format(),
        );
      }

      try {
        const programJson = await generateClimbingProgramFlow.run(
            validationResult.data,
        );

        if (!programJson) {
          throw new Error("Flow did not return a program.");
        }

        // Add the generated program to a 'trainingPlans' subcollection for user
        const userRef = admin.firestore().collection("users").doc(uid);
        const newPlanRef = userRef.collection("trainingPlans").doc();

        const programDataWithId = {...programJson, id: newPlanRef.id};

        await newPlanRef.set(programDataWithId);

        // Update the user's main document with a reference to the active plan
        await userRef.update({activeProgramId: newPlanRef.id});
        console.log("Program generated successfully");
        return {success: true, program: programDataWithId, planId: newPlanRef.id};
      } catch (error) {
        console.error("Error generating climbing program:", error);
        if (error instanceof z.ZodError) {
          throw new functions.https.HttpsError(
              "invalid-argument",
              "Invalid data provided",
              error.format(),
          );
        }
        console.error("Internal error:", error);
        throw new functions.https.HttpsError(
            "internal",
            "An unexpected error occurred.",
        );
      }
    },
);


