<template>
    <span style="position: static;">
        <span style="position: static;" v-if="locString.hasHtml" v-html="html"></span>
        <span style="position: static;" v-else>{{html}}</span>
    </span>
</template>

<script lang="ts">
    import Vue from 'vue'
    import {Component, Prop} from 'vue-property-decorator'
    import {LocalizableString} from "../localizablestring";

    @Component
    export default class SurveyString extends Vue {
        @Prop
        locString: LocalizableString

        // used to display values within an <option>
        @Prop
        strip: Boolean

        get html () {
            if (this.strip) {
                // convert <br /> and \n to spaces
                return this.locString.renderedHtml.replace(/<br\s*[\/]?>/gi, ' ').replace(/(?:\r\n|\r|\n)/g, ' ')
            } else {
                return this.locString.renderedHtml
            }
        }
    }

    Vue.component("survey-string", SurveyString)
</script>
