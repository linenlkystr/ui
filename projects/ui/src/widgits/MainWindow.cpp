//-------------------------------------------------------------------------------------------
//- Copyright 2018 Applied Research Associates, Inc.
//- Licensed under the Apache License, Version 2.0 (the "License"); you may not use
//- this file except in compliance with the License. You may obtain a copy of the License
//- at:
//- http://www.apache.org/licenses/LICENSE-2.0
//- Unless required by applicable law or agreed to in writing, software distributed under
//- the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//- CONDITIONS OF ANY KIND, either express or implied. See the License for the
//-  specific language governing permissions and limitations under the License.
//-------------------------------------------------------------------------------------------

//!
//! \author Steven A White
//! \date   June 24th 2018
//!
//!
//! \brief Primary window of BioGears UI

#include "MainWindow.h"
//External Includes
#include <QtWidgets>
//Project Includes
#include "ScenarioToolbar.h"
#include "MultiSelectionWidget.h"
namespace biogears_ui {

struct MainWindow::Implementation {
public:
  Implementation();
  Implementation(const Implementation&);
  Implementation(Implementation&&);

  Implementation& operator=(const Implementation&);
  Implementation& operator=(Implementation&&);

  MultiSelectionWidget* physiologySelection;
  ScenarioToolbar* runToolbar;
};
//-------------------------------------------------------------------------------
MainWindow::Implementation::Implementation()
  : physiologySelection(MultiSelectionWidget::create())
  , runToolbar(ScenarioToolbar::create())
{
}
//-------------------------------------------------------------------------------
MainWindow::Implementation::Implementation(const Implementation& obj)

{
  *this = obj;
}
//-------------------------------------------------------------------------------
MainWindow::Implementation::Implementation(Implementation&& obj)
{
  *this = std::move(obj);
}
//-------------------------------------------------------------------------------
MainWindow::Implementation& MainWindow::Implementation::operator=(const Implementation& rhs)
{
  if (this != &rhs) {
  }
  return *this;
}
//-------------------------------------------------------------------------------
MainWindow::Implementation& MainWindow::Implementation::operator=(Implementation&& rhs)
{
  if (this != &rhs) {
  }
  return *this;
}
//-------------------------------------------------------------------------------
MainWindow::MainWindow()
{
  //setCentralWidget(textEdit);
  createActions();
  createStatusBar();
  readSettings();
  setUnifiedTitleAndToolBarOnMac(true);
}
//-------------------------------------------------------------------------------
MainWindow::~MainWindow()
{
  _impl = nullptr;
}
//-------------------------------------------------------------------------------
void MainWindow::closeEvent(QCloseEvent* event)
{
  event->accept();
}
//-------------------------------------------------------------------------------
void MainWindow::about()
{
  QMessageBox::about(this, tr("About Application"),
    tr("The <b>Application</b> example demonstrates how to "
       "write modern GUI applications using Qt, with a menu bar, "
       "toolbars, and a status bar."));
}
void MainWindow::run()
{
  QMessageBox::about(this, tr("About Application"),
    tr("The <b>Application</b> example demonstrates how to "
       "write modern GUI applications using Qt, with a menu bar, "
       "toolbars, and a status bar."));
}
//-------------------------------------------------------------------------------
void MainWindow::createActions()
{
  //-- Create Header Menu
  QMenu* entry = nullptr;
  QToolBar* toolbar = nullptr;
  QAction* action = nullptr;

  //Simualtion
  entry = menuBar()->addMenu(tr("&Simulation"));
  //Simulation -> Launch
  QIcon launchIcon = QIcon::fromTheme("Launch", QIcon(":/img/play.png"));
  QAction* launch = action = new QAction(launchIcon, tr("&Launch"), this);
  action->setStatusTip(tr("Run current simulation"));
  connect(action, &QAction::triggered, this, &MainWindow::run);
  entry->addAction(action);

  //Simulation -> Load Scenario
  action = new QAction(launchIcon, tr("&Load Scenario"), this);
  action->setStatusTip(tr("Load an existing scenario file."));
  connect(action, &QAction::triggered, this, &MainWindow::run);
  entry->addAction(action);
  //Simulation -> Load Environment
  action = new QAction(launchIcon, tr("&Load Environment"), this);
  action->setStatusTip(tr("Load an existing environment file."));
  connect(action, &QAction::triggered, this, &MainWindow::run);
  entry->addAction(action);
  //Simulation -> Load Patient
  action = new QAction(launchIcon, tr("&Load Patient"), this);
  action->setStatusTip(tr("Load an existing psatient file."));
  connect(action, &QAction::triggered, this, &MainWindow::run);
  entry->addAction(action);
  //Simulation -> Exit
  entry->addSeparator();
  const QIcon exitIcon = QIcon::fromTheme("application-exit");
  QAction* exitAct = entry->addAction(exitIcon, tr("E&xit"), this, &QWidget::close);
  exitAct->setShortcuts(QKeySequence::Quit);
  exitAct->setStatusTip(tr("Exit the application"));

  //Help
  entry = menuBar()->addMenu(tr("&Help"));
  //Help -> Help
  action = entry->addAction(tr("&About"), this, &MainWindow::about);
  action->setStatusTip(tr("Show the application's About box"));
  //Help -> About
  action = entry->addAction(tr("About &Qt"), qApp, &QApplication::aboutQt);
  action->setStatusTip(tr("Show the Qt library's About box"));

  
  addToolBar(_impl->runToolbar);

  setCentralWidget(_impl->physiologySelection);
  connect(_impl->runToolbar, &ScenarioToolbar::patientChanged, this, &MainWindow::about);
  connect(_impl->runToolbar, &ScenarioToolbar::envonmentChanged, this, &MainWindow::about);
  connect(_impl->runToolbar, &ScenarioToolbar::timelineChanged, this, &MainWindow::about);
}
//-------------------------------------------------------------------------------
void MainWindow::createStatusBar()
{
  statusBar()->showMessage(tr("Ready"));
}
//-------------------------------------------------------------------------------
void MainWindow::readSettings()
{
  QSettings settings(QCoreApplication::organizationName(), QCoreApplication::applicationName());
  const QByteArray geometry = settings.value("geometry", QByteArray()).toByteArray();
  if (geometry.isEmpty()) {
    const QRect availableGeometry = QApplication::desktop()->availableGeometry(this);
    resize(availableGeometry.width() / 3, availableGeometry.height() / 2);
    move((availableGeometry.width() - width()) / 2,
      (availableGeometry.height() - height()) / 2);
  } else {
    restoreGeometry(geometry);
  }
}
//-------------------------------------------------------------------------------
void MainWindow::writeSettings()
{
  QSettings settings(QCoreApplication::organizationName(), QCoreApplication::applicationName());
  settings.setValue("geometry", saveGeometry());
}
}
