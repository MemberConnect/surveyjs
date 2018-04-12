<template>
  <div class="select-modal">
    <div v-if="showSelectModal">
      <select v-if="!question.isReadOnly" :id="question.inputId" :class="question.cssClasses.control" v-bind:aria-label="question.locTitle.renderedHtml" @click="popModal">
          <option value="">{{stripBr(modalSelectDisplay)}}</option>
      </select>
      <modal :open="showModal" :centered="true" @closed="modalClosed">
          <div slot="body">
              <ul v-if="!question.isReadOnly" v-bind:aria-label="question.locTitle.renderedHtml" class="list-unstyled">
                  <!-- dropdown -->
                  <li v-for="(item, index) in question.visibleChoices" :value="item.value" class="list-choice" @click="selectFromModal(item.value)" :class="{selected: model === item.value}">{{item.text}}</li>
                  <!-- matrix -->
                  <li v-for="(column, index) in question.columns" :value="column.value" class="list-choice" @click="selectFromModal(column.value)" :class="{selected: model === column.value}">
                    <survey-string :locString="column.locText" :strip="true" />
                  </li>
              </ul>
              <div v-else :text="question.displayValue" :class="question.cssClasses.control"></div>
          </div>
      </modal>
      <survey-other-choice v-show="question.hasOther && question.isOtherSelected" :class="question.cssClasses.other" :question="question"/>
    </div>
    <div v-else>
      <slot name="nomodal"></slot>
    </div>
  </div>
</template>

<script lang="ts">
  import Vue from 'vue'
  import {Component, Prop} from 'vue-property-decorator'

  @Component
  export default class SelectModal extends Vue {
      @Prop
      question: any

      @Prop
      model: any

      @Prop
      selected: any

      showModal: Boolean = false

      // these will be automatically included by vue-simple-breakpoints from dashboard-client
      $breakpoints: any

      get modalSelectDisplay() {
          if (this.model) {
              let selected = null

              if (this.question.visibleChoices) {
                // dropdown
                this.question.visibleChoices.forEach(q => {
                    if (q.value === this.model) selected = q
                })
              } else {
                // matrix
                this.question.columns.forEach(c => {
                    if (c.value === this.model) selected = c
                })
              }

              if (selected && selected.text) {
                  return this.stripBr(selected.text)
              } else {
                  return this.question.optionsCaption || 'Choose'
              }
          } else {
              return this.question.optionsCaption || 'Choose'
          }
      }

      get showSelectModal() {
        return this.question.survey.memberconnectCustomizations && this.question.survey.memberconnectCustomizations.mobile_android_select && (this.$breakpoints.isMobile() || this.$breakpoints.isTablet())
      }

      popModal (e) {
          e.preventDefault()
          e.target.blur()

          this.showModal = true
      }

      selectFromModal (val) {
          this.$emit('selected', val)
          this.showModal = false
      }

      modalClosed (closed) {
        this.showModal = !closed
      }

      stripBr (str) {
        return str.replace(/<br\s*[\/]?>/gi, ' ')
      }
  }

  Vue.component('select-modal', SelectModal)
</script>

<style scoped>
.list-choice {
    cursor: pointer;
    padding: 1.5em 1em;
    border-bottom:  1px solid #ccc;
    position: relative;
}

.list-choice:first-child {
    border-top-right-radius: 6px;
    border-top-left-radius: 6px;
}

.list-choice:last-child {
    border-bottom: 0;
    border-bottom-right-radius: 6px;
    border-bottom-left-radius: 6px;
}

.list-unstyled {
    margin-bottom: 0;
}
</style>
