<template>
    <div>
        <table :class="question.cssClasses.root" class="memberconnect-big-matrix">
            <thead>
                <tr>
                    <th v-show="question.hasRows"></th>
                    <th v-for="column in question.columns"><survey-string :locString="column.locText"/></th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(row, rowIndex) in question.visibleRows" :class="question.cssClasses.row">
                    <td v-show="question.hasRows"><survey-string :locString="row.locText"/></td>
                    <td v-for="(column, columnIndex) in question.columns">
                        <label :class="question.cssClasses.label" :style="{'margin': '0', 'position': 'absolute'}">
                            <input type="radio" :class="question.cssClasses.itemValue" :name="row.fullName" v-model="row.value" :value="column.value" :disabled="question.isReadOnly" :id="(columnIndex === 0) && (rowIndex === 0) ? question.inputId : ''"/>
                            <span class="circle"></span>
                            <span class="check"></span>
                        </label>
                    </td>
                </tr>
            </tbody>
        </table>
        <table :class="question.cssClasses.root" class="memberconnect-small-matrix">
            <thead>
                <tr>
                    <th v-show="question.hasRows"></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(row, rowIndex) in question.visibleRows" :class="question.cssClasses.row">
                    <td v-show="question.hasRows"><survey-string :locString="row.locText"/></td>
                    <td>
                        <select-modal :model="row.value" :question="question" @selected="(val) => row.value=val">
                            <div slot="nomodal">
                                <select :class="question.cssClasses.label" :style="{'margin': '0', 'width': '100%', 'background': '#E9ECF2'}" v-model="row.value">
                                    <option v-for="(column, columnIndex) in question.columns" :class="question.cssClasses.itemValue" :name="row.fullName" :value="column.value" :disabled="question.isReadOnly" :id="(columnIndex === 0) && (rowIndex === 0) ? question.inputId : ''">
                                        <survey-string :locString="column.locText" :strip="true"/>
                                    </option>
                                </select>
                            </div>
                        </select-modal>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script lang="ts">
    import Vue from 'vue'
    import {Component, Prop} from 'vue-property-decorator'
    import {default as Question} from './question'
    import {QuestionMatrixModel} from '../question_matrix'

    @Component
    export default class Matrix extends Question<QuestionMatrixModel> {
    }
    Vue.component("survey-matrix", Matrix)
</script>

<style>

.memberconnect-big-matrix {
    display: table;
}

.memberconnect-small-matrix {
    display: none;
}

.memberconnect-small-matrix .select-modal select {
    width: 100%;
}

@media screen and (max-width: 767px) {
    .memberconnect-big-matrix {
        display: none;
    }

    .memberconnect-small-matrix {
        display: table;
    }
}

@media screen and (max-width: 480px) {
    .memberconnect-big-matrix {
        display: none;
    }

    .memberconnect-small-matrix {
        display: table;
    }
}
</style>