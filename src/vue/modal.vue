<template>
  <div @click="closeModal">
    <div class="modal fade" :class="{in: open, centered: centered}" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <slot name="header" class="modal-header">
          </slot>
          <slot name="body" class="modal-body">
          </slot>
          <slot name="footer" class="modal-footer">
          </slot>
        </div>
      </div>
    </div>
    <div class="modal-backdrop fade" :class="{in: open}" data-id="backdrop"></div>
  </div>
</template>

<script lang="ts">
  import Vue from 'vue'
  import {Component, Prop, Watch} from 'vue-property-decorator'

  @Component
  export default class Modal extends Vue {
    @Prop
    open: Boolean

    @Prop
    centered: Boolean

    @Prop
    closed: any

    closeModal (e) {
      let bgClick = e.type === 'click' && e.target.classList.contains('modal')
      if (e.keyCode === 27 || bgClick) {
        this.$emit('closed', true)
      }
    }

    mounted () {
      window.addEventListener('keyup', this.closeModal)
    }

    destroyed () {
      window.removeEventListener('keyup', this.closeModal)
    }

  }

  Vue.component('modal', Modal)
</script>

<style scoped>
.modal {
  overflow-x: hidden;
  overflow-y: auto;
}
.modal.centered.in {
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal.centered .modal-content {
  margin-bottom: 30px;
}

@media screen and (max-width: 767px) {
  .modal.centered.in .modal-dialog {
    width: 100%;
  }
}

.modal.in {
  display: block;
}

.modal-dialog {
  max-height: 90vh;
  overflow: scroll;
}

.modal-backdrop {
  display: none;
}

.modal-backdrop.in {
  display: block;
}
</style>
