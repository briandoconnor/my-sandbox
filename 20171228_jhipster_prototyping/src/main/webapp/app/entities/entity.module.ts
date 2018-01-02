import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';

import { ConsonanceBlogModule } from './blog/blog.module';
import { ConsonanceEntryModule } from './entry/entry.module';
import { ConsonanceTagModule } from './tag/tag.module';
/* jhipster-needle-add-entity-module-import - JHipster will add entity modules imports here */

@NgModule({
    imports: [
        ConsonanceBlogModule,
        ConsonanceEntryModule,
        ConsonanceTagModule,
        /* jhipster-needle-add-entity-module - JHipster will add entity modules here */
    ],
    declarations: [],
    entryComponents: [],
    providers: [],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class ConsonanceEntityModule {}
