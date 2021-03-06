require File.dirname(__FILE__) + '/../../../../test_helper'

# TODO: rename under the namespace
class QuestionJournalPatchTest < ActionController::TestCase

  context "Journal" do
    subject {Journal.new}
    should_have_one :question

    should "destroy the question when the Journal is destroyed" do
      project = Project.generate!
      issue = Issue.generate_for_project!(project)
      issue.journal_notes = "Test"
      assert issue.save
      journal = issue.journals.last
      assert journal.valid?

      question = Question.generate!(:journal => journal, :issue => journal.issue)
      assert question.valid?

      assert_difference('Question.count', -1) do
        assert journal.reload.destroy
      end
    end
    
  end
end
