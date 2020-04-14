#include "SubstanceModel.h"

#include "QVariant"
#include "biogears/BioGearsData.h"

namespace bio {
SubstanceModel::SubstanceModel(QString prefix, QString name, QAbstractItemModel* parent)
  : QAbstractItemModel(parent)
  , _parent(parent)
{
}

//------------------------------------------------------------------------------------
SubstanceModel::~SubstanceModel()
{
  _children.clear();
}
//------------------------------------------------------------------------------------
void SubstanceModel::append(QString prefix, QString name, const biogears::SEScalar* data)
{
  PhysiologyRequest request;
  request.prefix = prefix;
  request.name = name;
  request.value = data;
  _children.append(request);
}
//------------------------------------------------------------------------------------
void SubstanceModel::append(QString prefix, QString name, const biogears::SEUnitScalar* data)
{
  PhysiologyRequest request;
  request.prefix = prefix;
  request.name = name;
  request.unit = data;
  _children.append(request);
}
//------------------------------------------------------------------------------------
void SubstanceModel::modify(int row, const biogears::SEUnitScalar* data)
{
  if (0 <= row && row < _children.size()) {
    _children[row].unit = data;
  }
}
//------------------------------------------------------------------------------------
void SubstanceModel::modify(int row, const biogears::SEScalar* data)
{
  if (0 <= row && row < _children.size()) {
    _children[row].value = data;
  }
}
//------------------------------------------------------------------------------------
int SubstanceModel::rowCount(const QModelIndex& index) const
{
  if (index.internalPointer() == this) {
    return _children.size();
  }
  return static_cast<QAbstractItemModel*>(index.internalPointer())->rowCount(index);
}
//------------------------------------------------------------------------------------
int SubstanceModel::columnCount(const QModelIndex& index) const
{
  if (index.isValid()) {
    return static_cast<QAbstractItemModel*>(index.internalPointer())->columnCount();
  }
  return 0;
}
//------------------------------------------------------------------------------------
QVariant SubstanceModel::data(const QModelIndex& index, int role) const
{
  if (!index.isValid()) {
    return QVariant();
  }
  if (COLUMN_COUNT <= index.column() || index.column() < 0) {
    return QVariant();
  }

  auto ip = static_cast<QAbstractItemModel*>(index.internalPointer());
  auto request = dynamic_cast<SubstanceModel*>(ip);
  if (request && request->_children.size() < index.row()) {

    auto value = request->_children[index.row()].value;
    auto unit = request->_children[index.row()].unit;
    auto prefix = request->_children[index.row()].prefix;
    auto name = request->_children[index.row()].name;

    switch (index.column()) {
    case PREFIX:
      return QVariant(prefix); // PREFIX ROLE
    case NAME:
      return QVariant(name);
    case VALUE: //VALUE ROLE
      try {
        return (unit) ? QVariant(unit->GetValue()) : (value) ? QVariant(value) : QVariant();
      } catch (biogears::CommonDataModelException e) {
        return "NaN";
      }
    case UNIT: //UNIT ROLE
      return (unit) ? QVariant(unit->GetUnit()->GetString()) : (value) ? QVariant("") : QVariant();
    default:
      return QVariant(QString("%s_%s").arg(prefix).arg(name));
    }
  } else {
    return QVariant();
  }
}
//------------------------------------------------------------------------------------
Qt::ItemFlags SubstanceModel::flags(const QModelIndex& index) const
{
  if (!index.isValid()) {
    return Qt::NoItemFlags;
  }

  return QAbstractItemModel::flags(index);
}
//------------------------------------------------------------------------------------
QVariant SubstanceModel::headerData(int section, Qt::Orientation orientation, int role) const
{
  if (orientation == Qt::Horizontal && role == Qt::DisplayRole) {
    switch (section) {
    case 0:
      return "Prefix";
      break;
    case 1:
      return "Request";
      break;
    case 2:
      return "Value";
      break;
    case 3:
      return "Unit";
      break;
    case 4:
      return "Full Name";
      break;
    default:
      return QVariant();
    }
  }
  return QVariant();
}
//------------------------------------------------------------------------------------
QModelIndex SubstanceModel::index(int row, int column, const QModelIndex& parent) const
{
  if (!hasIndex(row, column, parent)) {
    return QModelIndex();
  }
  void* childItem;

  if (!parent.isValid()) {
    if (0 <= row && row < _children.size()) {
      childItem = const_cast<PhysiologyRequest*>(&_children[row]);
      return createIndex(row, column, childItem);
    }
  } else {
    //NOTE IF Physiology Request could have sub request this would be where to handle that.
  }
  return QModelIndex();
}
//------------------------------------------------------------------------------------
QModelIndex SubstanceModel::parent(const QModelIndex& index) const
{
  if (index.internalPointer() == this) {
    return dynamic_cast<BioGearsData const*>(_parent)->index(this);
  }
  return QModelIndex();
}
//------------------------------------------------------------------------------------
} //namespace bio