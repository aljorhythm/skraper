import { test, expect } from "@playwright/test";

test.describe.serial("init", async () => {
  test("health api should return", async ({ page }) => {
    const response = await page.request.get("/api/health");
    expect(await response.ok()).toBeTruthy();
  });
});
