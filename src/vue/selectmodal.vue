<template>
  <div>
    <div v-if="showSelectModal">
      <select v-if="!question.isReadOnly" :id="question.inputId" :class="question.cssClasses.control" v-bind:aria-label="question.locTitle.renderedHtml" @click=popModal>
          <option value=''>{{modalSelectDisplay}}</option>
      </select>
      <modal :show="showModal" :centered="true">
          <div slot="body">
              <ul v-if="!question.isReadOnly" v-bind:aria-label="question.locTitle.renderedHtml" class="list-unstyled">
                  <li v-for="(item, index) in question.visibleChoices" :value="item.value" class="list-choices" @click="selectFromModal(item.value)" :class="{selected: value === item.value}">{{item.text}}</li>
              </ul>
              <div v-else :text="question.displayValue" :class="question.cssClasses.control"></div>
              <survey-other-choice v-show="question.hasOther && question.isOtherSelected" :class="question.cssClasses.other" :question="question"/>
          </div>
      </modal>
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
      value: any

      showModal: Boolean = false

      get modalSelectDisplay() {
          if (this.value) {
              let selected = null
              this.question.visibleChoices.forEach(q => {
                  if (q.value === this.value) selected = q
              })

              if (selected && selected.text) {
                  return selected.text
              } else {
                  return this.question.optionsCaption
              }
          } else {
              return this.question.optionsCaption
          }
      }

      get showSelectModal() {
        return this.question.survey.wiselyCustomizations && this.question.survey.wiselyCustomizations.mobile_android_select
      }

      popModal (e) {
          e.preventDefault()
          e.target.blur()

          this.showModal = true
      }

      selectFromModal (val) {
          this.value = val
          this.showModal = false
      }
  }

  Vue.component('select-modal', SelectModal)
</script>

<style scoped>
.list-choices {
    cursor: pointer;
    padding: 1.5em 1em;
    border-bottom:  1px solid #ccc;
}

.list-choices:first-child {
    border-top-right-radius: 6px;
    border-top-left-radius: 6px;
}

.list-choices:last-child {
    border-bottom: 0;
    border-bottom-right-radius: 6px;
    border-bottom-left-radius: 6px;
}

.list-choices.selected {
    background-color: #ccc;
}

.list-unstyled {
    margin-bottom: 0;
}
</style>
