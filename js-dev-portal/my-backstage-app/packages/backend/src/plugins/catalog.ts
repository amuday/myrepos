import { CatalogBuilder } from '@backstage/plugin-catalog-backend';
import { ScaffolderEntitiesProcessor } from '@backstage/plugin-catalog-backend-module-scaffolder-entity-model';
import { Router } from 'express';
import { PluginEnvironment } from '../types';
import { GitlabFillerProcessor } from '@immobiliarelabs/backstage-plugin-gitlab-backend';
//import { GitlabDiscoveryEntityProvider } from '@backstage/plugin-catalog-backend-module-gitlab';
import { GitLabDiscoveryProcessor } from '@backstage/plugin-catalog-backend-module-gitlab';
//import { GithubEntityProvider } from '@backstage/plugin-catalog-backend-module-github';
//import { GithubOrgEntityProvider } from '@backstage/plugin-catalog-backend-module-github';
import { GitlabOrgDiscoveryEntityProvider } from '@backstage/plugin-catalog-backend-module-gitlab';

export default async function createPlugin(
  env: PluginEnvironment,
): Promise<Router> {
  const builder = await CatalogBuilder.create(env);
  builder.addProcessor(new ScaffolderEntitiesProcessor());

  // below plugin is community
  builder.addProcessor(new GitlabFillerProcessor(env.config));
  
  // builder.addEntityProvider(
  //   ...GitlabDiscoveryEntityProvider.fromConfig(env.config, {
  //     logger: env.logger,
  //     // optional: alternatively, use scheduler with schedule defined in app-config.yaml
  //     schedule: env.scheduler.createScheduledTaskRunner({
  //       frequency: { minutes: 30 },
  //       timeout: { minutes: 3 },
  //     }),
  //     // optional: alternatively, use schedule
  //     scheduler: env.scheduler,
  //   }),
  // );

  builder.addProcessor(
    GitLabDiscoveryProcessor.fromConfig(env.config, { logger: env.logger }),
  );

  builder.addEntityProvider(
    ...GitlabOrgDiscoveryEntityProvider.fromConfig(env.config, {
      logger: env.logger,
      // optional: alternatively, use scheduler with schedule defined in app-config.yaml
      schedule: env.scheduler.createScheduledTaskRunner({
        frequency: { minutes: 30 },
        timeout: { minutes: 3 },
      }),
    }),
  );

  // builder.addEntityProvider(
  //   GithubEntityProvider.fromConfig(env.config, {
  //     logger: env.logger,
  //     // optional: alternatively, use scheduler with schedule defined in app-config.yaml
  //     schedule: env.scheduler.createScheduledTaskRunner({
  //       frequency: { minutes: 30 },
  //       timeout: { minutes: 3 },
  //     }),
  //     // optional: alternatively, use schedule
  //     scheduler: env.scheduler,
  //   }),
  // );

  // builder.addEntityProvider(
  //   GithubOrgEntityProvider.fromConfig(env.config, {
  //     id: 'production',
  //     orgUrl: 'https://github.com/backstage',
  //     logger: env.logger,
  //     schedule: env.scheduler.createScheduledTaskRunner({
  //       frequency: { minutes: 60 },
  //       timeout: { minutes: 15 },
  //     }),
  //   }),
  // );

  const { processingEngine, router } = await builder.build();
  await processingEngine.start();
  return router;
}
