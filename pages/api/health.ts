import { NextApiRequest, NextApiResponse } from "next";

type HealthData = {};

export default function handler(
  _: NextApiRequest,
  res: NextApiResponse<HealthData>
) {
  res.status(200).json({});
}
